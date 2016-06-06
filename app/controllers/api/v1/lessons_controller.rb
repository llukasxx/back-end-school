class Api::V1::LessonsController < ApplicationController
  before_action :authenticate_user_from_token!

  def get_lessons
    lessons = Lesson.all.includes(:groups).paginate(page: params[:page])
    count = Lesson.all.count
    lessons = lessons.map {|l| ReceiverLessonSerializer.new(l).as_json(root: false) }
    render json: { lessons: lessons, count: count }
  end
end
