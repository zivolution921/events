class EventsController < ApplicationController
  #passing data through instance variable to the index page
  def index
    @events = ['BugSmash', 'Hackathon', 'Kat Camp', 'Rails User Group']
  end
end
