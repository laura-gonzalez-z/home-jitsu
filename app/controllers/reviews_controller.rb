class ReviewsController < ApplicationController
  def index
    @users = User.all
    @review = policy_scope(Review)
    @reviews_all = Review.all
    @reviews = @reviews_all.select { |review| review.user_id == params[:user_id].to_i }
  end
end
