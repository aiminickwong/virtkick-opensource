namespace :ipaddr do
  desc 'set reserved IPs for development and production'
  task :import => :environment do
    IpRange.delete_all
    Ip.delete_all

    def add_ips ip_prefix, range, range_object
      range.each do |num|
        Ip.create \
            ip: "#{ip_prefix}.#{num}",
            ip_range_id: range_object.id
      end
    end

    range_object = IpRange.create \
        netmask: '255.255.255.224',
        gateway: '192.168.0.1'

    add_ips '192.168.0', 100..200, range_object
  end
end
