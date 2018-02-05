require 'active_hash'

class Infra::Machine < Infra::Base
  attr_accessor :id
  attr_accessor :hostname, :uuid, :memory
  attr_accessor :processors, :processor_usage
  attr_accessor :status
  attr_accessor :vnc_password, :vnc_port, :vnc_listen_ip
  attr_accessor :disks
  attr_accessor :networks
  attr_accessor :iso_distro_id, :iso_image_id


  def self.all
    Wvm::Machine.all
  end

  def self.find hostname
    Wvm::Machine.find hostname
  end

  def self.create new_machine
    Wvm::Machine.create new_machine
  end

  def id
    @id ||= MetaMachine.where(hostname: hostname).first.id
  end

  %w(start pause resume stop force_stop restart force_restart).each do |operation|
    define_method operation do
      Wvm::Machine.send operation, hostname
    end
  end

  def create_disk disk
    Wvm::Machine.add_disk disk, self
  end

  def delete_disk disk
    Wvm::Machine.delete_disk disk, self
  end

  def mount_iso iso_image
    Wvm::Machine.mount_iso self, iso_image
  end

  def iso_distro
    Plans::IsoDistro.find @iso_distro_id if @iso_distro_id
  end

  def iso_image
    Plans::IsoImage.find @iso_image_id if @iso_image_id
  end

  def delete
    Wvm::Machine.delete self
  end


  class Status < ActiveHash::Base
    # TODO: https://github.com/pluginaweek/state_machine

    self.data = [
        {id: :running, name: 'Running', running: true, icon: 'fa fa-play'},
        {id: :saved, name: 'Saved', running: false, icon: 'fa fa-stop'},
        {id: :suspended, name: 'Paused', running: false, icon: 'fa fa-pause'},
        {id: :stopped, name: 'Stopped', running: false, icon: 'fa fa-stop'},
        {id: :unknown, name: 'Unknown', running: nil, icon: 'fa fa-question'}
    ]

    def stopped?
      running === false
    end

    def running?
      running
    end

    def to_s
      name
    end
  end
end
