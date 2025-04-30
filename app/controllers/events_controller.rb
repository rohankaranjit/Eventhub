class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_organizer!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: "Event created successfully!"
    else
      render :new, alert: "Something went wrong."
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event updated!"
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event deleted."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_organizer!
    unless current_user.organizer?
      redirect_to root_path, alert: "Only organizers can do that."
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date, :capacity)
  end
end
