class MacAddrGenerator
  def generate
    # TODO: generate unicast mac address only, not multicast
    (1..6).map { '%0.2X' % rand(256) }.join ':'
  end
end
