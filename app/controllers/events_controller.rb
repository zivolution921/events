class EventsController < ApplicationController
  #passing data through instance variable to the index page
  def index
    @events = Event.all
  end
end
