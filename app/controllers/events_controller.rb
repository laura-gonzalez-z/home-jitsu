class EventsController < ApplicationController
  before_action :set_user

  def index
    @event = policy_scope(Event)
    @events = Event.all
  end

  def new
    @event = Event.new
    authorize @event
  end

  private

  def set_user
    @user = current_user
  end
end
