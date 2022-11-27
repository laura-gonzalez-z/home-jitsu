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
    # TODO
    @chatrooms = Chatroom.all
    authorize @chatrooms
  end

  private

  def chatroom_params
    params.permit(:name)
  end
end
