class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    set_notifications_to_read
    authorize @chatroom
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    authorize @chatroom
    @chatroom.save
    redirect_to chatroom_path(@chatroom)
  end

  def my_messages
    @chatrooms = Chatroom.where("name LIKE ?", "%_#{current_user.id}_%").includes(:messages).order('messages.created_at DESC')
    authorize @chatrooms
  end

  private

  def chatroom_params
    params.permit(:name)
  end

  def set_notifications_to_read
    notifications = @chatroom.notifications_as_chatroom.where(recipient: current_user).unread
    notifications.update_all(read_at: Time.zone.now)
  end
end
