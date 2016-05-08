class AddDescriptionToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :description, :string
  end
end
