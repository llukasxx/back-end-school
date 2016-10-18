class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    groups_query = Group::GroupQuery.new(teacher_id: query_params[:teacher_id])
    render json: groups_query.result_query, 
           meta: { count: groups_query.count }
  end

  private

    def query_params
      params.permit(:teacher_id, :query, :page)
    end

end
