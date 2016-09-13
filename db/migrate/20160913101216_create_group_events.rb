class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.integer :event_id
      t.integer :group_id

      t.timestamps null: false
    end
    add_index :group_events, :event_id
    add_index :group_events, :group_id
  end
end
