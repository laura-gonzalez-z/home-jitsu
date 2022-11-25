class PartnersController < ApplicationController

  def create
    @partner = Partner.new(partner_params)
    authorize @partner
    @partner.save
    redirect_to users_path
  end

  private

  def partner_params
    puts :requestee_id
    puts :requester_id
    params.permit(:requestee_id, :requester_id)
  end
end
