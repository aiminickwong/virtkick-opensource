class IpRange < ActiveRecord::Base
  has_many :ip_addresses
end
