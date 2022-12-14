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
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      notify_recipient
      set_message_notifications_as_read
      head :ok
    else
      @messages = @chatroom.messages.order('messages.created_at asc')
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
      next if user.eql?(current_user)

      notification = MessageNotification.with(message: @message.content, chatroom: @message.chatroom, type: "message")
      notification.deliver(user)
    end
  end

  def set_message_notifications_as_read
    notifications = @chatroom.notifications_as_chatroom.where(recipient: current_user).unread
    notifications.update_all(read_at: Time.zone.now)
  end
end
