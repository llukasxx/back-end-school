class Api::V1::Receivers::ReceiversStudentsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    students_query = User::UserQuery.new(search_query: query_params[:query], 
                                         account_type: 'student')
    render json: students_query.result_query.page(query_params[:page]), 
           each_serializer: StudentSerializer, 
           root: 'students',
           meta: { count: students_query.count }, 
           status: :ok
  end

  private

    def query_params
      params.permit(:query, :page)
    end
   
end