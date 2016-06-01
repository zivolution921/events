class EventsController < ApplicationController
  # will run require_signin method before every method will run
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  
  def index
    # upcoming method defined in the event model all upcoming events
    @events = Event.upcoming    
  end

  def show
    # hash params to find event based on id from url
    @event = Event.find(params[:id])
    @likers = @event.likers
    # categories for each event
    @categories = @event.categories
    # return like object only if logged in
    if current_user
      @current_like = current_user.likes.find_by(event_id: @event.id)
    end
  end
  
  def edit
    # finding placeholder :id that we find in url
    @event = Event.find(params[:id])
  end
  
  def update
    # returns true or false based on validation on record on database
    @event = Event.find(params[:id])
    if @event.update(event_params)
    # redirect to event path and rails figure out to go to show page
    # flash object hash with key and value :notice
      redirect_to @event, notice: "Event successfully updated!"
    else
      render :edit
    end
  end
  
  def new
    # instantiate empty event objet and render new view template erb
    @event = Event.new
    @event.categories.build
  end
  
  def create
    # instantiate new Event object with permitted parameter and save to database
    # setting up event in memory and calling save method
    @event = Event.new(event_params)
    #save method will call the validations if it is true will redirect to show page
    if @event.save
    # redirecting by convention to show page
      redirect_to @event, notice: "Event successfully created!"
    else
    # render new template and prepopulate the form 
    # with all the valid form data that were captured
    # @event instance var so preserve all the valid form and highlight invalid
      render :new
    end
  end

  def destroy
    # lookup event_id in the url
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, alert: "Event successfully deleted!"
  end
    
private
  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end
  def event_params
    # permit attributes to be assigned to avoid hackers
    # array mass assigned to category_ids
    params.require(:event).permit(
      :name, :description,
      :location, :price, :starts_at, 
      :image_file_name, :capacity, 
      categories_attributes: [ :id, :name ]
    )
  end
end
