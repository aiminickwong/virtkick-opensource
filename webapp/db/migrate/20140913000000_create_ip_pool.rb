class CreateIpPool < ActiveRecord::Migration
  def change
    create_table :ip_ranges do |t|
      t.string :netmask
      t.string :gateway
      t.integer :hypervisor_id, default: 1 # TODO: remove once we support more hypervisors
    end

    create_table :ips do |t|
      t.integer :ip_range_id
      t.string :ip
      t.boolean :taken, default: false
      t.string :vm_uuid # TODO: referce to Machine ID once introduced
    end
  end
end
