class GuestsController < ApplicationController
  before_action :set_event, only: %i[create accept reject]
  before_action :set_guest, only: %i[accept reject]

  def create
    @guest = Guest.new
    @guest.event_id = @event.id
    @guest.guest_id = current_user.id
    authorize @guest
    if @guest.save
      notify_host if @guest.status == "Pending"
      redirect_to event_path(@event)
    else
      render event_path(@event), :unprocessable_entity
    end
  end

  def invite
    @guest = Guest.new
    @guest.event_id = params[:event_id]
    @guest.guest_id = params[:guest_id]
    @guest.status = "Invited"
    authorize @guest
    if @guest.save
      notify_recipient
      redirect_to invite_partners_path(current_user)
    else
      render invite_partners_path(current_user), :unprocessable_entity
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

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_guest
    @guest = Guest.find(params[:guest_id])
  end

  def notify_host
    host = User.find(@guest.event.host)
    notification = GuestNotification.with(type: "join", host: host,
                                          recipient: @guest.guest, status: @guest.status)
    notification.deliver(host)
  end

  def notify_recipient
    guest = @guest.guest
    notification = GuestNotification.with(type: "invite", host: @guest.event.host,
                                          recipient: guest, status: @guest.status)
    notification.deliver(guest)
  end
end
