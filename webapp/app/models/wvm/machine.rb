require 'ipaddress'

class Wvm::Machine < Wvm::Base
  def self.all
    response = call :get, 'instances'
    machines = build_all_instances response

    Infra::Elements.new machines
  end

  def self.find id
    response = call :get, "instance/#{id}"

    params = {
      hostname: response[:name],
      uuid: response[:uuid],
      memory: response[:cur_memory],
      processors: response[:vcpu],
      status: determine_status(response),
      vnc_password: response[:vnc_password],
      disks: Wvm::Disk.array_of(response.disks)
    }

    if response.media and not response.media.empty?
      file = response.media.first.image
      iso_image = Plans::IsoImage.by_file(file).first

      if iso_image
        params[:iso_image_id] = iso_image.id
        params[:iso_distro_id] = iso_image.iso_distro.id
      end
    end

    Infra::Machine.new params
  end

  def self.create new_machine
    machine = build_new_machine new_machine

    template = File.dirname(__FILE__) + '/new_machine.xml.slim'
    xml = Slim::Template.new(template, format: :xhtml).render Object.new, {machine: machine}
    call :post, 'create', create_xml: '',
        from_xml: xml

    machine = Infra::Machine.find machine.hostname

    machine.create_disk Infra::Disk.new \
        size: new_machine.plan.storage,
        type: new_machine.plan.storage_type

    machine
  end

  OPERATIONS = {
      start: :start,
      pause: :suspend,
      resume: :resume,
      stop: :shutdown,
      force_stop: :destroy,
      restart: :restart
  }

  OPERATIONS.each do |operation_name, libvirt_name|
    define_singleton_method operation_name do |id|
      operation libvirt_name, id
    end
  end

  def self.force_restart id
    operation :destroy, id
    operation :start, id
  end

  def self.add_disk disk, machine
    disk.device = machine.disks.next_device_name
    Wvm::Disk.create disk, machine.uuid

    call :post, "instance/#{machine.hostname}", assign_volume: '',
        file: disk.path, device: disk.device
  end

  def self.delete_disk disk, machine
    call :post, "instance/#{machine.hostname}", unassign_volume: '',
        device: disk.device

    Wvm::Disk.delete disk
  end

  def self.mount_iso machine, iso_image
    call :post, "instance/#{machine.hostname}", mount_iso: '',
        media: iso_image.file # device purposely omitted
  end

  def self.delete machine
    call :post, "instance/#{machine.hostname}", delete: '',
        delete_disk: ''
  end


  private
  def self.sum_up object, &property
    object.map(&property).inject(0, &:+)
  end

  def self.operation operation, id
    call :post, 'instances', operation => '', name: id
  end

  def self.determine_status response
    status = case response[:status]
      when 1
        :running
      when 3
        :suspended
      when 5
        response[:has_managed_save_image] == 1 ? :saved : :stopped
      else
        :unknown
    end
    Infra::Machine::Status.find status
  end

  def self.build_all_instances response
    machines = response.instances.map do |machine|
      Infra::Machine.new \
          hostname: machine[:name],
          memory: machine[:memory],
          disks: Wvm::Disk.array_of(machine.storage),
          status: determine_status(machine)
    end
    machines.sort_by &:hostname
  end

  def self.build_new_machine new_machine
    uuid = SecureRandom.uuid
    networks = setup_networks uuid

    Infra::Machine.new \
        uuid: uuid,
        hostname: new_machine.hostname,
        memory: new_machine.plan.memory,
        processors: new_machine.plan.cpu,
        iso_distro_id: new_machine.iso_distro.id,
        iso_image_id: new_machine.iso_distro.iso_images.first.id,
        networks: networks,
        vnc_listen_ip: ENV['VNC_FORCE_IP'] || '10.255.2.10', # TODO: extract to settings
        vnc_password: SecureRandom.urlsafe_base64(32)
  end

  def self.setup_networks uuid
    networks = Infra::Networks.new
    networks.public = Infra::Network.new \
        pool_name: 'default',
        dhcp_network: IPAddress('192.168.123.0/24') # TODO: extract to settings
    networks
  end
end
