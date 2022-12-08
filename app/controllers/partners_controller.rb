class PartnersController < ApplicationController
  before_action :set_partner, only: %i[accept reject destroy]

  def index
    @partners = policy_scope(Partner)
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
    notify_requester
    set_notifications_to_read
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
    notification = PartnerNotification.with(recipient: @partner.requestee, status: @partner.status, requester: @partner.requester)
    notification.deliver(recipient)
  end

  def notify_requester
    recipient = User.find(@partner.requester_id)
    notification = PartnerNotification.with(recipient: @partner.requester, status: @partner.status, requestee: @partner.requestee)
    notification.deliver(recipient)
  end
end
