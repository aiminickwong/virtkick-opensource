class MachineDeleteJob < BaseJob
  self.set_max_attempts 10, 15.seconds

  def perform meta_machine_id
    machine = MetaMachine.find meta_machine_id
    machine.destroy
  end
end
