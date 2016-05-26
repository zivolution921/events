class EventsController < ApplicationController
  
  def index
    @events = Event.upcoming    
  end

  def show
    @event = Event.find(params[:id])
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    # returns true or false based on validation on record on database
    @event = Event.find(params[:id])
    if @event.update(event_params)
    # flash object hash with key and value :notice
      redirect_to @event, notice: "Event successfully updated!"
    else
      render :edit
    end
  end
  
  def new
    @event = Event.new
  end
  
  def create
    # setting up event in memory and calling save method
    @event = Event.new(event_params)
    #save method will call the validations if it is true will redirect to show page
    if @event.save
      redirect_to @event, notice: "Event successfully created!"
    else
    # render new template and prepopulate the form with all the valid form data and highlight invalid
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, alert: "Event successfully deleted!"
  end
    
private

  def event_params
    params.require(:event).permit(:name, :description, :location, :price, :starts_at, :image_file_name, :capacity)
  end
end
