class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user_from_token!
  def get_events
    events = Event.all
    render json: events
  end
end