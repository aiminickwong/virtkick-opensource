describe Infra::Network do
  require 'ipaddress'

  let(:network) {
    Infra::Network.new dhcp_network: IPAddress('192.168.123.0/24')
  }

  context 'DHCP' do
    it 'is DHCP' do
      expect(network.dhcp?).to eq true
    end

    it 'lists all available hosts' do
      ips = network.dhcp_pool.map &:to_s

      expect(ips).not_to include '192.168.123.0' # network
      expect(ips).not_to include '192.168.123.255' # broadcast
      expect(ips).not_to include '192.168.123.1' # reserved for gateway and DNS

      expect(ips).to include '192.168.123.2'
      expect(ips).to include '192.168.123.254'

      expect(ips.size).to eq 253
    end
  end
end
