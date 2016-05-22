class EventsController < ApplicationController
  #passing data through instance variable to the index page
  def index
    @events = Event.all
  end

  def show
    #fail
    @event = Event.find(params[:id])
  end
end
