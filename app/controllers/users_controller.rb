class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = policy_scope(User)
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
    @message = "Edit your profile"
  end

  def update
    authorize @user
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :weight, :height, :belt,
                                 :years_of_experience, :address, :description, :gender)
  end
end
