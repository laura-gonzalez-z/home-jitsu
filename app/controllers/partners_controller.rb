class PartnersController < ApplicationController
  before_action :set_partner, only: %i[accept reject destroy]

  def index
    @partners = policy_scope(Partner)
  end

  def create
    @partner = Partner.new(partner_params)
    authorize @partner
    @partner.save
    redirect_to user_path(:requestee_id)
  end

  def destroy
    authorize @partner
    @partner.destroy
    redirect_to user_path(:requestee_id)
  end

  def accept
    raise
    authorize @partner
    @partner.update(status: "accepted")
    redirect_to user_path(:requestee_id)
  end

  def reject
    raise
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
end
