class Api::V1::Receivers::ReceiversGroupsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    groups_query = Group::GroupQuery.new(search_query: query_params[:query])
    render json: groups_query.result_query.page(query_params[:page]),
                 each_serializer: ReceiverGroupSerializer, root: 'groups',
                 meta: { count: groups_query.count }
  end

  private

    def query_params
      params.permit(:query, :page)
    end

end
