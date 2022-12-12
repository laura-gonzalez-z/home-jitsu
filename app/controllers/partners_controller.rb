class PartnersController < ApplicationController
  before_action :set_partner, only: %i[accept reject destroy]

  def index
    @partners = policy_scope(Partner)
  end

  def invite_partners_list
    @event = Event.find(params[:format])
    @user = User.find(current_user.id)
    authorize @user
    @partners = Partner.select { |partner| partner.requester_id == current_user.id || partner.requestee_id == current_user.id }
    @guests = Guest.select { |guest| guest.event_id == @event.id }
    @guests_ids = []
    @guests.each { |guest| @guests_ids << guest.guest_id }
  end

  def create
    @partner = Partner.new(partner_params)
    authorize @partner
    @partner.save
    notify_recipient if @partner.status == "pending"
    redirect_to user_path(:requestee_id)
  end

  def destroy
    authorize @partner
    @partner.destroy
    redirect_to user_path(:requestee_id)
  end

  def accept
    authorize @partner
    @partner.update(status: "accepted")
    notify_requester
    set_notifications_to_read
    redirect_to user_path(:requestee_id)
  end

  def reject
    authorize @partner
    @partner.update(status: "rejected")
    redirect_to user_path(:requestee_id)
  end

  private

  def set_partner
    @other_user = User.find(params[:id])
    @partner = Partner.find_by(requestee_id: @other_user.id, requester_id: current_user.id) ||
               Partner.find_by(requester_id: @other_user.id, requestee_id: current_user.id)
  end

  def partner_params
    params.permit(:requestee_id, :requester_id)
  end

  def set_notifications_to_read
    current_user.notifications.mark_as_read!
  end

  def notify_recipient
    recipient = User.find(@partner.requestee_id)
    notification = PartnerNotification.with(
      type: "user",
      message: "#{@partner.requester.first_name} invited you to be their partner.",
      recipient: @partner.requestee,
      link_to: @partner.requester
    )
    notification.deliver(recipient)
  end

  def notify_requester
    requester = User.find(@partner.requester_id)
    notification = PartnerNotification.with(
      type: "user",
      message: "#{@partner.requestee.first_name} accepted your partner request.",
      recipient: @partner.requestee,
      link_to: @partner.requestee
    )
    notification.deliver(requester)
  end
end
