class RegistrationsController < ApplicationController
  # will run set_event method before every method will run
  before_action :set_event

  def index
    # params hash to find the specific event_id
    # the event object will associate to registration
    # event_id is passed and we asign the registration object
    # query scoped to the particular event, registrations belong to the event
    @registrations = @event.registrations
  end

  def new
    @registration = @event.registrations.new
  end

  def create
    # the registration is tied to the event
    @registration = @event.registrations.new(registration_params)
    if @registration.save
      redirect_to event_registrations_path(@event),
        notice: "Thanks for registering!"
    else
      render :new
    end
  end

private

  def registration_params
    params.require(:registration).permit(:name, :email, :how_heard)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

end
