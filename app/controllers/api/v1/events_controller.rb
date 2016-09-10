class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def get_upcoming_events
    events = Event.upcoming.paginate(page: params[:page])
    render json: events
  end

  def get_past_events
    events = Event.past.paginate(page: params[:page])
    render json: events
  end

end