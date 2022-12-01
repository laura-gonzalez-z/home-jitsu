class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
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
end
