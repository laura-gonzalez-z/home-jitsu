class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: {message: @message})
      )
      notify_recipient
      head :ok
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def notify_recipient
    users_in_room = @message.joined_users
    users_in_room.each do |user|
      next if user.eql?(@message.user_id)

      notification = MessageNotification.with(message: @message.content, chatroom: @message.chatroom)
      notification.deliver_later(user)
    end
  end
end
