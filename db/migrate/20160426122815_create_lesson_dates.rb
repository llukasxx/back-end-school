class CreateLessonDates < ActiveRecord::Migration
  def change
    create_table :lesson_dates do |t|
      t.datetime :date
      t.integer :lesson_id

      t.timestamps null: false
    end
    add_index :lesson_dates, :lesson_id
  end
end
