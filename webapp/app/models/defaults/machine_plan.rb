require 'active_hash'

class Defaults::MachinePlan < ActiveHash::Base
  plans = [
      [0.5, 20, 'HDD', 1],
      [1, 30, 'HDD', 1],
      [2, 50, 'HDD', 2],
      # [4, 70, 'HDD', 2],
      # [8, 90, 'HDD', 3]
  ]

  self.data = plans.map.with_index do |plan, i|
    {
      id: i + 1, memory: plan[0], cpu: plan[3],
      storage: plan[1].gigabytes, storage_type: plan[2]
    }
  end
end
