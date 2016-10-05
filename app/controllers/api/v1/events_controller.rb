class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user_from_token!

  def create
    event = @current_user.events.new(event_params)
    if event.save!
      render json: event
    else
      render json: event.errors, status: 400
    end
  end

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
    events = events.map {|e| EventSerializer.new(e).as_json(root: false) }
    render json: { events: events, count: Event.past.count }
  end

  def get_past_connected_events
    teachers_groups_ids = @current_user.groups_teacher.pluck(:id).uniq
    connected_events = Event.past.page(params[:page]).joins(:groups).where('groups.id': teachers_groups_ids).uniq
    events = connected_events.map {|e| EventSerializer.new(e).as_json(root: false) }
    render json: { events: events, count: connected_events.count }
  end

  def get_past_created_events
    teacher_events = @current_user.events.past.page(params[:page])
    events = teacher_events.map {|e| EventSerializer.new(e).as_json(root: false) }
    render json: { events: events, count: teacher_events.count }
  end

  private

    def event_params
      params.require(:event).permit(:name, :date, :group_ids => [])
    end

end