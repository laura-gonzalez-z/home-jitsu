class ReviewsController < ApplicationController
  before_action :set_user, only: %i[index new create]

  def index
    @users = User.all
    @review = policy_scope(Review)
    @reviews_all = Review.all
    @reviews = @reviews_all.select { |review| review.user_id == @user.id.to_i }
    mark_notification_as_read(params[:notification_id])
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.writer_id = current_user.id
    @review.user_id = @user.id
    authorize @review
    if @review.save
      notify_recipient
      redirect_to user_reviews_path(@user)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def notify_recipient
    recipient = User.find(@review.user_id)
    notification = ReviewNotification.with(
      type: "review",
      message: "#{@review.writer.first_name} left you a #{@review.rating}-star review",
      link_to: @review.user
    )
    notification.deliver(recipient)
  end
end
