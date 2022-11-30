class GuestsController < ApplicationController
  before_action :set_event, only: %i[create]

  def create
    @guest = Guest.new
    @guest.event_id = @event.id
    @guest.guest_id = current_user.id
    authorize @guest
    if @guest.save
      redirect_to event_path(@event)
    else
      render event_path(@event), :unprocessable_entity
    end
  end

  def destroy
    @guest = Guest.find(params[:id])
    authorize @guest
    if @guest.destroy
      redirect_to event_path
    else
      render events_path, :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
