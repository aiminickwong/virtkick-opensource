class Ip < ActiveRecord::Base
  # belongs_to :machine # TODO
  belongs_to :ip_range

  scope :not_taken, -> {
    where taken: false
  }
  scope :ip_to_take, -> {
    not_taken.limit 1
  }
  scope :taken_by, ->(vm_uuid) {
    where(taken: true, vm_uuid: vm_uuid).limit 1
  }
end
