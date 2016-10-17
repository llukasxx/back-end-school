class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    events = Event.filtered(filter: query_params[:filter], 
                          kind: query_params[:kind], 
                          user: @current_user).page(query_params[:page])
    count = Event.filtered(filter: query_params[:filter], 
                          kind: query_params[:kind], 
                          user: @current_user).count
    render json: events, meta: { count: count }
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