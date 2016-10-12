class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    if groups_params[:query] && !groups_params[:query].empty?
      groups = Group.with_lessons.search_by_name(groups_params[:query]).page(groups_params[:page])
      group_count = groups.count
      render json: groups, each_serializer: ReceiverGroupSerializer, meta: { count: group_count }
    elsif groups_params[:teacher_id]
      teacher_groups = User.find(groups_params[:teacher_id]).groups_teacher.uniq
      # GroupSerializer fires off here
      render json: teacher_groups
    else
      group_count = Group.all.count
      render json: Group.with_lessons, each_serializer: ReceiverGroupSerializer, meta: { count: group_count } 
    end
  end

  private

    def groups_params
      params.permit(:teacher_id, :query, :page)
    end

end
