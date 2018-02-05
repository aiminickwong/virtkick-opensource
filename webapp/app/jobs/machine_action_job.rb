class MachineActionJob < TrackableJob
  self.set_max_attempts 1, 2.seconds

  def perform meta_machine_id, action
    machine = MetaMachine.find(meta_machine_id).machine
    machine.public_send action
  end
end
