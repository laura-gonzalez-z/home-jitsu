class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if user_signed_in?
      @average_rating = []
      @average_rating = current_user.reviews.average(:rating).round(2) if current_user.reviews.exists?
    else

    end
  end
end
