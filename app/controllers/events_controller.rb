class EventsController < ApplicationController
  before_action :set_user

  def index
    @event = policy_scope(Event)
    @events = Event.all
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    authorize @event
    @event.host = current_user
    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def event_params
    params.require(:event).permit(:date, :title, :description, :status)
  end
end
