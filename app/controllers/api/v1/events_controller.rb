class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def get_upcoming_events
    events = Event.upcoming.page(params[:page])
    events = events.map {|e| EventSerializer.new(e).as_json(root: false) }
    render json: { events: events, count: Event.upcoming.count }
  end

  # This returns events whos groups belongs to teacher
  def get_upcoming_connected_events
    teachers_groups_ids = @current_user.groups_teacher.pluck(:id).uniq
    connected_events = Event.upcoming.page(params[:page]).joins(:groups).where('groups.id': teachers_groups_ids).uniq
    events = connected_events.map {|e| EventSerializer.new(e).as_json(root: false) }
    render json: { events: events, count: connected_events.count }
  end

  def get_upcoming_created_events
    teacher_events = @current_user.events.upcoming.page(params[:page])
    events = teacher_events.map {|e| EventSerializer.new(e).as_json(root: false) }
    render json: { events: events, count: teacher_events.count }
  end

  def get_past_events
    events = Event.past.page(params[:page])
    render json: events
  end

end