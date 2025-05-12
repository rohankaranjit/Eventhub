class PagesController < ApplicationController
  before_action :authenticate_user!

  def success
    event = Event.find_by(id: params[:event_id])
    return redirect_to root_path, alert: "Event not found." unless event

    unless current_user.reservations.exists?(event: event)
      Reservation.create(user: current_user, event: event)
      event.update(capacity: event.capacity - 1) if event.capacity > 0
    end
  end
  def cancel
    @event = Event.find(params[:event_id])
    flash[:alert] = "Payment was canceled. You were not registered."
    redirect_to event_path(@event)
  end
end
