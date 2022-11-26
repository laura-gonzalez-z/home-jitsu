class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end
  def my_messages
    # TODO
    @chatrooms = Chatroom.all
    authorize @chatrooms
  end
end
