class PartnersController < ApplicationController
  before_action :set_partner, only: %i[destroy]

  def create
    @partner = Partner.new(partner_params)
    authorize @partner
    @partner.save
    redirect_to users_path
  end

  def destroy
    authorize @partner
    @partner.destroy
    redirect_to users_path
  end

  private

  def set_partner
    @other_user = User.find(params[:id])
    @partner = Partner.find_by(user: current_user)
  end

  def partner_params
    params.permit(:requestee_id, :requester_id)
  end
end
