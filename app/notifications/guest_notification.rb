# To deliver this notification:
#
# GuestNotification.with(post: @post).deliver_later(current_user)
# GuestNotification.with(post: @post).deliver(current_user)

class GuestNotification < Noticed::Base
  deliver_by :database
  deliver_by :action_cable, channel: ChatroomChannel, stream: :custom_stream, format: :action_cable_data
  def custom_stream
    "user_#{recipient.id}"
  end

  def action_cable_data
    { user_id: recipient.id }
  end

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
