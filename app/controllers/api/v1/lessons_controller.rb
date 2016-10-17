class Api::V1::LessonsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    if lesson_params[:query] && !lesson_params[:query].empty?
      lessons = Lesson.with_groups.search_by_name(lesson_params[:query]).page(lesson_params[:page])
      lessons_count = lessons.count
      render json: lessons, each_serializer: ReceiverLessonSerializer, meta: { count: lessons_count }, status: :ok
    elsif lesson_params[:student_id]
      student = User.find(lesson_params[:student_id])
      lessons = student.student_lessons.includes(:lesson_dates)
      render json: lessons, each_serializer: SimpleStudentLessonSerializer, scope: current_user, status: :ok
    else
      lessons = Lesson.with_groups.page(lesson_params[:page])
      lessons_count = Lesson.all.count
      render json: lessons, each_serializer: ReceiverLessonSerializer, meta: { count: lessons_count }, status: :ok
    end
  end


  private

    def lesson_params
      params.permit(:query, :page, :student_id)
    end

end
