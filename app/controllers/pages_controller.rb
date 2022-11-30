class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if user_signed_in?
      if current_user.reviews.exists?
        @average_rating = current_user.reviews.average(:rating).round(2)
      end
    else

    end
  end
end
