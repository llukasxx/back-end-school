class CreateGroupStudents < ActiveRecord::Migration
  def change
    create_table :group_students do |t|
      t.integer :student_id
      t.integer :group_id

      t.timestamps null: false
    end
    add_index :group_students, :student_id
    add_index :group_students, :group_id
  end
end
