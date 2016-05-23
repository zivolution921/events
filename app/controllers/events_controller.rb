class EventsController < ApplicationController
  #passing data through instance variable to the index page
  def index
    @events = Event.all
  end

  def show
    #fail
    @event = Event.find(params[:id])
  end

  def edit
    #finding placholder in route :id
    # fetch id params from database
    @event = Event.find(params[:id])
  end

  def update
    # event data from the form
    @event = Event.find(params[:id])
    # hash data came from the form
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def new
  #instantiate an empty event object and render new view template
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to @event
  end

  private
  def event_params
    # explicitly which params could be changed via the form mass assignment
    # explicitly permit attributes from the form can me mass assignened
    event_params = params.require(:event).permit(:name, :description, :location, :price)
  end
end
