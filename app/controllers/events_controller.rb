class EventsController < ApplicationController
  before_action :set_user, only: %i[create]
  before_action :set_event, only: %i[destroy]

  def index
    @event = policy_scope(Event)
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end

  def new
    @event = Event.new
    authorize @event
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to events_path
  end

  def create
    @event = Event.new(event_params)
    authorize @event
    @event.host = current_user
    @event.status = "Open"
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

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:date, :title, :description)
  end
end
