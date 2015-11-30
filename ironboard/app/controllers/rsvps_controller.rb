class RsvpsController < ApplicationController

def create
  @event = Event.find(params[:id])
  # move logic into a method
  if !@event.guests.include?(current_user.guest)
  @event.guests << current_user.guest
  else
    flash[:notice] = "You're already attending this event!"
  end
  render 'events/show' 
end

end
