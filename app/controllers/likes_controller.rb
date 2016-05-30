class LikesController < ApplicationController
  before_action :require_signin
  before_action :set_event

  def create
    # event_id is in the url
    # scoping down to likes where foreign key point to event.id
    # user.likes.find_by(event_id: event.id)
    # @event will be the route for creating like to be associated to event
    @event.likes.create!(user: current_user)
    redirect_to @event, notice: "Glad you liked it!"
  end

  def destroy 
    # like that belong to the user and has an id according to url
    like = current_user.likes.find(params[:id])
    like.destroy

    @event = Event.find(params[:event_id])
    redirect_to @event, notice: "Sorry!"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

end
