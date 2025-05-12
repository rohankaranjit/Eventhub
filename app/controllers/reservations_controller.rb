class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:id])
    if event.reservations.count < event.capacity
      event.reservations.create(user: current_user)
      redirect_to event_path(event), notice: "You have registered for this event!"
    else
      redirect_to event_path(event), alert: "Sorry, event is fully booked."
    end
  end

  def destroy
    event = Event.find(params[:id])
    reservation = event.reservations.find_by(user: current_user)
    reservation.destroy if reservation
    redirect_to event_path(event), notice: "You have cancelled your registration."
  end

  def index
    @reservations = current_user.reservations.includes(:event)
    @events = current_user.registered_events
  end
end
