class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home loading]

  def home
    if user_signed_in?
      if current_user.reviews.exists?
        @average_rating = current_user.reviews.average(:rating).round(2)
      end
      @users = User.joins(:reviews)
      .group('users.id')
      .order('avg(reviews.rating) desc')
      .limit(4)
    else
      @users = User.joins(:reviews)
      .group('users.id')
      .order('avg(reviews.rating) desc')
      .limit(2)
    end
    @events = Event.all
    upcoming, past = @events.sort_by(&:date).partition{ |a| a.date.future? }
    @sorted = [[*upcoming], [*past.reverse]]
  end

  def loading
  end
end
