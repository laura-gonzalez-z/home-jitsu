class EventsController < ApplicationController
  before_action :set_user, only: %i[create my_events]
  before_action :set_event, only: %i[edit update destroy show]

  def index
    # TODO: Just filter upcoming events
    @events = Event.all
    policy_scope(@events)


    if params[:query].present?
      geocoded_search_results = Geocoder.search(params[:query])
      top_result = geocoded_search_results.first
      unless top_result.nil?
        @events = @events.near(top_result.address, 5)
      else
        @events = []
      end
    else
      @events = @events.where.not(latitude: nil)
      unless current_user.latitude.nil?
        @events = @events.sort_by { |event| event.distance_to([current_user.latitude, current_user.longitude]).round(1) }
      end
    end

    if params[:name].present?
      @events = @events.select { |event| event.host.first_name == params[:name] }
    end

    if params[:date].present?
      date = DateTime.parse(params[:date]).to_i + 18_000
      @events = @events.select { |event| date <= event.date.to_i && event.date.to_i <= (date + (60 * 60 * 24)) }
    end

    @markers = @events.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        info_window: render_to_string(partial: "info_window", locals: {event: event})
      }
    end
  end

  def show
    authorize @event
    @confirmed_guests = Guest.select { |guest| guest.event_id == @event.id && guest.status == "Accept" }
    @pending_guests = Guest.select { |guest| guest.event_id == @event.id && guest.status == "Pending" }
    @invited_guests = Guest.select { |guest| guest.event_id == @event.id && guest.status == "Invited" }
    @include_guest = [@event.host_id]
    @confirmed_guests.each { |guest| @include_guest << guest.guest_id }
    @pending_guests.each { |guest| @include_guest << guest.guest_id }
    @invited_guests.each { |guest| @include_guest << guest.guest_id }
    @confirmed_guests_ids = @confirmed_guests.map { |guest| guest.guest_id }
    @pending_guests_ids = @pending_guests.map { |guest| guest.guest_id }
    @invited_guests_ids = @invited_guests.map { |guest| guest.guest_id }
    @markers = [
      {
        lat: @event.latitude,
        lng: @event.longitude,
        info_window: render_to_string(partial: "info_window", locals: { event: @event })
      }
    ]
    set_notifications_to_read
  end

  def my_events
    authorize @user
    @joined_events = Guest.select { |guest| guest.guest_id == current_user.id && guest.status == "Accept" }
    @invited_events = Guest.select { |guest| guest.guest_id == current_user.id && guest.status == "Invited" }
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

  def set_notifications_to_read
    current_user.notifications.mark_as_read!
  end
end
