class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    events_query = Event::EventQuery.new(filter: query_params[:filter],
                                         kind: query_params[:kind],
                                         user: @current_user)
    render json: events_query.result_query.page(query_params[:page]), 
                 meta: { count: events_query.count }, status: :ok
  end

  def create
    event = @current_user.events.new(event_params)
    if event.save!
      render json: event
    else
      render json: event.errors, status: 400
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :date, :group_ids => [])
    end

    def query_params
      params.permit(:filter, :page, :kind)
    end

end