require 'active_hash'

class Infra::Elements < Array
  include Enumerable

  def deep_sum *properties
    obj = self
    while property = properties.shift
      proc = property.to_proc
      obj = obj.map(&proc).flatten.compact
    end

    obj ? obj.sum : 0
  end
end
