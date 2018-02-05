require 'active_hash'

class Infra::Network < Infra::Base
  attr_accessor :mac
  attr_accessor :ip4, :ip6
  attr_accessor :pool_name
  attr_accessor :dhcp_network

  def dhcp?
    not dhcp_network.nil?
  end

  def dhcp_pool
    ip = []
    dhcp_network.each_host do |addr|
      ip << addr
    end
    ip.shift # reserved for gateway and DNS
    ip
  end
end
