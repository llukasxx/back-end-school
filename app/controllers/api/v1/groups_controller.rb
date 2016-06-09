class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user_from_token!

  def teacher_groups
    render json: @current_user.groups_teacher.uniq
  end

  def teacher_group
    group = Group.find(params[:id])
    render json: group
  end

  def get_groups
    if params[:query] && !params[:query].empty?
      groups = Group.search_by_name(params[:query]).includes(:lessons).paginate(page: params[:page])
      count = groups.count
      groups = groups.map {|g| ReceiverGroupSerializer.new(g).as_json(root: false) }
      render json: { groups: groups, count: count }
    else
      groups = Group.all.includes(:lessons).paginate(page: params[:page])
      count = Group.all.count
      groups = groups.map {|g| ReceiverGroupSerializer.new(g).as_json(root: false) }
      render json: { groups: groups, count: count }
    end
  end

end
