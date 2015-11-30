class Guest < ActiveRecord::Base

  has_many :ratings
  belongs_to :user
  has_many :rsvps
  has_many :events, through: :rsvps
  # belongs_to :host, 

  include GuestHostMethods

  def rate(event, rating)
    if self.past_events.include?(event)
      # dont need to pass in event.id, instead could just do event: event
      Rating.create(event_id: event.id, stars: rating, guest_id: self.id)
    end
  end

  def rated?(user, event)
    # dont need to pass in event.id, instead could just do event: event
    Rating.find_by(guest_id: user.id, event_id: event.id)
  end

  def self.with_the_most
    # nice method
    Guest.select('guests.*,count(events.id) as events_count').joins(:events).
    group('guests.id').order('events_count desc limit 1')
  end

end
