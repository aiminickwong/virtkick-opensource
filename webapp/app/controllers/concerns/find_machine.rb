module FindMachine
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!

    def self.find_machine_before_action key, *options
      before_action(*options) do
        @meta_machine = current_user.meta_machines.find params[key]
        @machine = @meta_machine.machine
      end
    end
  end
end
