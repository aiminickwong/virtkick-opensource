class DiskDeleteJob < TrackableJob
  self.set_max_attempts 10, 15.seconds

  # TODO: Warning, the ID is now 'vda' instead of filename. It may possibly delete a wrong disk!
  def perform meta_machine_id, disk_id
    machine = MetaMachine.find(meta_machine_id).machine
    disk = machine.disks.find disk_id
    machine.delete_disk disk
  end
end
