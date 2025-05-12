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
    @event.price = params[:event][:price].to_f * 100  # Convert dollars to cents

    if @event.save
      redirect_to @event, notice: "Event created successfully!"
    else
      flash.now[:alert] = "Something went wrong."
      render :new
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
    if current_user.admin? || @event.user == current_user
      @event.destroy
      redirect_to events_path, notice: "Event deleted."
    else
      redirect_to events_path, alert: "You are not allowed to delete this event."
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_organizer!
    unless current_user.organizer? || current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end  

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date, :capacity, :image, :price)
  end
end
