class Api::V1::Receivers::ReceiversTeachersController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    teachers_query = User::UserQuery.new(search_query: query_params[:query], 
                                         account_type: 'teacher')
    render json: teachers_query.result_query.page(query_params[:page]), 
           each_serializer: TeacherSerializer, 
           root: 'teachers',
           meta: { count: teachers_query.count }, 
           status: :ok
  end

  private

    def query_params
      params.permit(:query, :page)
    end
   
end