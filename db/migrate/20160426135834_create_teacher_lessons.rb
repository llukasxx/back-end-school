class CreateTeacherLessons < ActiveRecord::Migration
  def change
    create_table :teacher_lessons do |t|
      t.integer :teacher_id
      t.integer :lesson_id

      t.timestamps null: false
    end
    add_index :teacher_lessons, :teacher_id
    add_index :teacher_lessons, :lesson_id
  end
end
