class EventsController < ApplicationController
  #passing data through instance variable to the index page
  def index
    #custome query method built
    @events = Event.upcoming
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
    redirect_to @event
  end

  def new
  #instantiate an empty event object and render new view template
    @event = Event.new
  end

  def create
    # instantiate new object event with permitted params and save to database
    # redirect_to show page
    @event = Event.new(event_params)
    @event.save
    redirect_to @event
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url
  end

  private
  def event_params
    # explicitly which params could be changed via the form mass assignment
    # explicitly permit attributes from the form can me mass assignened
    params.require(:event).permit(:name, :description, :location, :price, :starts_at, :image_file_name, :capacity)
  end
end
