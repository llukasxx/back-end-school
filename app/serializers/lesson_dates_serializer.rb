class LessonDatesSerializer < ActiveModel::Serializer
  attributes :id, :date

  def date
    object.date.to_s(:db)
  end
end
