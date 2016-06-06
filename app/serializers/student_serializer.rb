class StudentSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name

  def total_count
    serialization_options[:total_count]
  end
end
