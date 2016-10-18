class Api::V1::Receivers::ReceiversLessonsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    lessons_query = Lesson::LessonQuery.new(search_query: query_params[:query])
    render json: lessons_query.result_query.page(query_params[:page]),
                 each_serializer: ReceiverLessonSerializer, root: 'lessons',
                 meta: { count: lessons_query.count }
  end


  private

    def query_params
      params.permit(:query, :page, :student_id)
    end

end
