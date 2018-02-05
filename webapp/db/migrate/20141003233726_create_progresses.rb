class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.integer :user_id, null: false
      t.boolean :finished, default: false, null: false
      t.string :error
      t.timestamps null: false
    end

    add_index :progresses, :user_id
  end
end
