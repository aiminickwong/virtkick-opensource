class CreateMetaMachines < ActiveRecord::Migration
  def change
    create_table :meta_machines do |t|
      t.string :hostname
      t.integer :user_id
      t.integer :libvirt_hypervisor_id
      t.string :libvirt_machine_name
      # TODO: move libvirt_* to generic :backend_properties so multiple classes of backends are supported
      t.timestamps null: false
    end

    add_index :meta_machines, :user_id
  end
end
