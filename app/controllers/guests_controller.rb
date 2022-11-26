class GuestsController < ApplicationController
  before_action :set_event, only: %i[create]

  def create
    @guest = Guest.new
    @guest.event_id = @event.id
    @guest.guest_id = current_user.id
    if @guest.save
      redirect_to events_path
    else
      render event_path(@event), :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
