class CreateNewMachines < ActiveRecord::Migration
  def change
    create_table :new_machines do |t|
      t.string :hostname
      t.integer :user_id
      t.integer :plan_id
      t.integer :iso_distro_id
      t.integer :iso_image_id
      t.string :current_step, default: 'create_machine'
      t.boolean :step_create_machine
      # t.boolean :step_create_disk # TODO
      # t.boolean :start_machine # TODO
      t.boolean :finished, default: false
      # t.string :given_ip # TODO
      # t.string :given_netmask
      # t.string :given_gateway
      # t.string :given_hypervisor
      t.integer :given_libvirt_hypervisor_id
      t.string :given_libvirt_machine_name
      t.integer :given_meta_machine_id
      t.string :error_message
      t.timestamps
    end

    add_index :meta_machines, :hostname, unique: true
  end
end
