class Api::V1::Receivers::ReceiversLessonsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    lessons_query = Lesson::LessonQuery.new(search_query: query_params[:query])
    render json: lessons_query.result_query.page(query_params[:page]),
                 each_serializer: ReceiverLessonSerializer, root: 'lessons',
                 meta: { count: lessons_query.count }
    # if lesson_params[:query] && !lesson_params[:query].empty?
    #   lessons = Lesson.with_groups.search_by_name(lesson_params[:query]).page(lesson_params[:page])
    #   lessons_count = lessons.count
    #   render json: lessons, each_serializer: ReceiverLessonSerializer, meta: { count: lessons_count }, status: :ok
    # elsif lesson_params[:student_id]
    #   student = User.find(lesson_params[:student_id])
    #   lessons = student.student_lessons.includes(:lesson_dates)
    #   render json: lessons, each_serializer: SimpleStudentLessonSerializer, scope: current_user, status: :ok
    # else
    #   lessons = Lesson.with_groups.page(lesson_params[:page])
    #   lessons_count = Lesson.all.count
    #   render json: lessons, each_serializer: ReceiverLessonSerializer, meta: { count: lessons_count }, status: :ok
    # end
  end


  private

    def query_params
      params.permit(:query, :page, :student_id)
    end

end
