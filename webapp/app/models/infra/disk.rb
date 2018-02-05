require 'active_hash'

class Infra::Disk < Infra::Base
  attr_accessor :path, :name, :format

  attr_accessor :size, :used
  attr_accessor :device, :type

  attr_reader :size_plan # create only
  define_attribute_methods :size_plan


  def id
    device
  end

  def save
    raise if persisted?
    Wvm::Disk.create self
  end

  def size_plan= size_plan
    size_plan = Defaults::DiskSizePlan.find(size_plan) unless size_plan.is_a? Defaults::DiskSizePlan
    @size = size_plan.size
    @size_plan = size_plan
  end

  %w(snapshot delete).each do |operation|
    define_method operation do
      Wvm::Disk.send operation, id
      raise
    end
  end

  def persisted?
    true if self.path
  end
end
