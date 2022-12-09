class GuestsController < ApplicationController
  before_action :set_event, only: %i[create accept reject]
  before_action :set_guest, only: %i[accept reject]

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

  def accept
    authorize @guest
    @guest.update(status: "Accept")
    redirect_to event_path(@event)
  end

  def reject
    authorize @guest
    @guest.update(status: "Reject")
    redirect_to event_path(@event)
  end

  def invite

  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_guest
    @guest = Guest.find(params[:guest_id])
  end
end
