class EventsController < ApplicationController
  before_action :set_user, only: %i[create my_events]
  before_action :set_event, only: %i[edit update destroy show]

  def index
    # TODO: Just filter upcoming events
    if params[:query].present?
      sql_query = "address ILIKE :query"
      @events = policy_scope(Event).where(sql_query, query: "%#{params[:query]}%")
    else
      @events = policy_scope(Event)
    end
    @markers = @events.geocoded.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: {event: event})
      }
    end
  end

  def show
    authorize @event
    @guests = Guest.select { |guest| guest.event_id == @event.id }
    @markers = [
      {
        lat: @event.latitude,
        lng: @event.longitude,
        info_window: render_to_string(partial: "info_window", locals: {event: @event})
      }
    ]
  end

  def my_events
    authorize @user
    @joined_events = Guest.select { |guest| guest.guest_id == current_user.id }
    @events = Event.select { |event| event.host_id == current_user.id }
    upcoming, past = @events.sort_by(&:date).partition{ |a| a.date.future? }
    @sorted = [[*upcoming], [*past.reverse]]
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
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @event
  end

  def update
    authorize @event
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :new, :unprocessable_entity
    end
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to events_path
  end

  private

  def set_user
    @user = current_user
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:date, :title, :address, :description, :photo)
  end
end
