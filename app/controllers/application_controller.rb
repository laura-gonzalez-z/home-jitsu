class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name weight height belt years_of_experience address description gender photo training_style])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name weight height belt years_of_experience address description gender photo training_style])
  end

  def set_notifications
    notifications = Notification.where(recipient: current_user)
    @unread = notifications.unread
    @read = notifications.read
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def mark_notification_as_read(notification)
    Notification.find(notification).mark_as_read! if notification
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
