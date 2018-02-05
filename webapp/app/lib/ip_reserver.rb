class IpReserver
  class NoIpLeft < StandardError; end

  def reserve_ip vm_uuid
    # TODO: store Machine ID once model is introduced
    Ip.transaction do
      ip = reserved_ip vm_uuid
      return ip if ip

      affected_rows = Ip.ip_to_take.update_all taken: true, vm_uuid: vm_uuid
      raise NoIpLeft if affected_rows == 0

      reserved_ip vm_uuid
    end
  end

  def reserved_ip vm_uuid
    Ip.taken_by(vm_uuid).first
  end
end

