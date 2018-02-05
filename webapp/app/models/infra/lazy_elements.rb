require 'active_hash'

class Infra::LazyElements
  def initialize array
    @array = array
  end

  def deep_sum *properties
    obj = self
    while property = properties.shift
      proc = property.to_proc
      obj = obj.map(&proc).flatten.compact
    end

    obj ? obj.sum : 0
  end

  def method_missing symbol, *args
    @array.send symbol, *args
  end
end
