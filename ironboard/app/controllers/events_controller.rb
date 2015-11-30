class EventsController < ApplicationController
  before_action :user_authorized, except: [:index,:show]

  def index
    @events = Event.sort_by_day
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.host = current_user.host
    @event.title = @event.title.capitalize 
    # move this loic into a mehtod, good amount of repetition here
      if  @event.day != nil && @event.validate_day? && @event.save 
        redirect_to event_path(@event)
      elsif @event.day != nil && !@event.validate_day? 
          flash[:notice] = "Invalid date"
          redirect_to new_event_path , notice: "Invalid date"
      elsif !@event.save || @event.day == nil
          render 'new'
      end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
    if !permission_to_edit?(@event.host.user)
      flash[:notice] = "You do not have permission to edit this event."
      render 'show'
    end
  end

  def update
    event = Event.find(params[:id])
    event.update(event_params)
    redirect_to event_path(event)
  end


  private

  
  def event_params
    params.require(:event).permit(:title, :day, :start_time, :end_time, :description, :location, tag_ids: [], tags_attributes: [:name])
  end
  
end
