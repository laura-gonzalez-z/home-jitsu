class EventsController < ApplicationController
  before_action :set_usern, only: %i[create]

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

  def event_params
    params.require(:event).permit(:date, :title, :description)
  end
end
