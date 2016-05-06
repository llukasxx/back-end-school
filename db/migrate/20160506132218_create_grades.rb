class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.integer :lesson_id
      t.string :grade
      t.timestamps null: false
    end
    add_index :grades, :student_id
    add_index :grades, :teacher_id
    add_index :grades, :lesson_id
  end
end
