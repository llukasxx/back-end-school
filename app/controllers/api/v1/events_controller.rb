class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def get_upcoming_events
    events = Event.upcoming.page(params[:page])
    events = events.map {|e| EventSerializer.new(e).as_json(root: false) }
    render json: { events: events, count: Event.upcoming.count }
  end

  # def get_upcoming_connected_events
    
  #   events = Event.upcoming.page(params[:page])
  #   events = events.map {|e| EventSerializer.new(e).as_json(root: false) }
  #   render json: { events: events, count: Event.upcoming.count }
  # end

  def get_past_events
    events = Event.past.page(params[:page])
    render json: events
  end

end