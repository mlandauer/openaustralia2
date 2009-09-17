module CommentsHelper
  # Override implementation provided by rails to match the results of the php implementation
  def time_ago_in_words(time)
    d = Time.now - time
    months = (d / 4.weeks).floor
    d -= months * 4.weeks
    weeks = (d / 1.week).floor
    d -= weeks.weeks
    days = (d / 1.day).floor
    d -= days.days
    hours = (d / 1.hour).floor
    d -= hours.hours
    minutes = (d / 1.minute).floor
    d -= minutes.minutes
    seconds = (d / 1.second).floor
    
    if months > 0
      text = time.to_date.to_s(:simple)
    elsif weeks > 0
      text = pluralize(weeks, 'week')
      text += ", " + pluralize(days, 'day') if days > 0
    elsif days > 0
      text = pluralize(days, 'day')
      text += ", #{pluralize(hours, 'hour')}" if hours > 0
    elsif hours > 0
      text = pluralize(hours, 'hour')
      text += ", #{pluralize(minutes, 'minute')}" if minutes > 0
    elsif minutes > 0
      text = pluralize(minutes, 'minute')
      text += ", #{pluralize(seconds, 'second')}" if seconds > 0
    else
      text = pluralize(seconds, 'second')
    end
    text
  end
end
