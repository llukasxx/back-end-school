class CreateGroupLessons < ActiveRecord::Migration
  def change
    create_table :group_lessons do |t|
      t.integer :group_id
      t.integer :lesson_id

      t.timestamps null: false
    end
    add_index :group_lessons, :group_id
    add_index :group_lessons, :lesson_id
  end
end
