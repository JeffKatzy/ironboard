module GuestHostMethods
# very nice
  def past_events
    self.events.past
  end

  def upcoming_events
    self.events.upcoming
  end

  def rating(event)
    rating = Rating.where("event_id = ? and guest_id = ?", event.id, self.id).first
    rating.stars
  end

end