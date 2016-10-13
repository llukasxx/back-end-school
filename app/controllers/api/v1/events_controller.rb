class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    if query_params[:filter] == 'upcoming'
      if query_params[:kind] == 'connected'
        connected_events = Event.upcoming_connected(@current_user).page(query_params[:page])
        render json: connected_events, meta: { count: Event.upcoming_connected(@current_user).count }
      elsif query_params[:kind] == 'created'
        created_events = Event.upcoming_created(@current_user).page(query_params[:page])
        render json: created_events, meta: { count: Event.upcoming_created(@current_user).count }
      else
        events = Event.upcoming.page(query_params[:page])
        upcoming_events_count = Event.upcoming.count
        render json: events, meta: { count:  upcoming_events_count }
      end
    elsif query_params[:filter] == 'past'
      if query_params[:kind] == 'connected'
        connected_events = Event.past_connected(@current_user).page(query_params[:page])
        render json: connected_events, meta: { count: Event.past_connected(@current_user).count }
      elsif query_params[:kind] == 'created'
        created_events = Event.past_created(@current_user).page(query_params[:page])
        render json: created_events, meta: { count: Event.past_created(@current_user).count }
      else
        events = Event.past.page(query_params[:page])
        past_events_count = Event.past.count
        render json: events, meta: { count: past_events_count }
      end
    end
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