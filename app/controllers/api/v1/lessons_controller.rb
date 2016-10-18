class Api::V1::LessonsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    lessons_query = Lesson::LessonQuery.new(student_id: query_params[:student_id])
    render json: lessons_query.result_query, 
                 each_serializer: SimpleStudentLessonSerializer,
                 scope: current_user
  end


  private

    def query_params
      params.permit(:student_id)
    end

end
