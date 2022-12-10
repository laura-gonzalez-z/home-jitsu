class GuestsController < ApplicationController
  before_action :set_event, only: %i[create accept reject]
  before_action :set_guest, only: %i[accept reject]

  def create
    @guest = Guest.new
    @guest.event_id = @event.id
    @guest.guest_id = current_user.id
    @guest.status = "Pending"
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
    previous_status = @guest.status
    @guest.update(status: "Accept")
    notify_guest_accept if previous_status == "Pending"
    notify_host_accept if previous_status == "Invited"
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
    host = @guest.event.host
    notification = GuestNotification.with(type: "join", host: host,
                                          recipient: @guest.guest, status: @guest.status, event: @guest.event)
    notification.deliver(host)
  end

  def notify_recipient
    guest = @guest.guest
  # notification = GuestNotification.with(type: "invite", host: @guest.event.host,
  #                                        recipient: guest, status: @guest.status, event: @guest.event)

    notification = GuestNotification.with(
      type: "event",
      message: "#{@guest.event.host.first_name} invited you to their event.",
      recipient: @guest.guest,
      link_to: @guest.event
    )
    notification.deliver(guest)
    raise
  end

  def notify_guest_accept
    host = @guest.event.host
    notification = GuestNotification.with(type: "host-accept-join", host: host,
                                          recipient: @guest.guest, status: @guest.status, event: @guest.event)
    notification.deliver(guest)
  end

  def notify_host_accept
    guest = @guest.guest
    notification = GuestNotification.with(type: "guest-accept-invite", host: @guest.event.host,
                                          recipient: guest, status: @guest.status, event: @guest.event)

    notification = GuestNotification.with(
      type: "event",
      message: "#{notification.params[:recipient].first_name} accepted the invite to your event.",
      recipient: @guest.guest,
      link_to: @guest.event
    )
    notification.deliver(host)
  end
end
