class EventViewObject
  # great use of view object
  def initialize(event)
    @event = event
  end

  def starts_at
  	am_pm = "AM"
		am_pm = "PM" if @event.start_time.hour>=12
		hour = "#{@event.start_time.hour%12}"
    hour = '0'+ hour  if hour.length == 1
  	minutes = "#{@event.start_time.min}"
  	minutes = '0'+minutes if minutes.length == 1
    # consider using the strftime library
  	"#{hour}:#{minutes} #{am_pm}"
  end

	def ends_at
    # these methods are using some repetition with the starts at method
    # has too much logic for one method

    # consider using the strftime library
		am_pm = "AM" 	
		am_pm = "PM" if @event.end_time.hour>12
		hour = "#{@event.end_time.hour%12}"
    hour = '0'+ hour  if hour.length == 1
  	minutes = "#{@event.end_time.min}"
  	minutes = '0'+minutes if minutes.length == 1
  	"#{hour}:#{minutes} #{am_pm}"
  end

  def guests_attending
    num_guests = @event.guests.count
    case num_guests
    when 0
      "No guests have RSVP'd yet!"
    when 1
      "1 guest has RSVP'd: "
    else
      "#{num_guests} guests have RSVP'd: "
    end
  end

end