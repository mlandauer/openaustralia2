# Used for date formatting in OpenAustralia
# has form: 18 November 2008
Date::DATE_FORMATS[:simple] = lambda {|date| date.strftime("#{date.day} %B %Y")}
Date::DATE_FORMATS[:simple_with_day] = lambda {|date| date.strftime("#{Date::DAYNAMES[date.wday]}, #{date.day} %B %Y")}
Date::DATE_FORMATS[:simple_short] = lambda {|date| date.strftime("#{date.day} %b %Y")}
# 12 Hour clock with am/pm
Time::DATE_FORMATS[:time_12] = lambda {|date| date.strftime("%I:%M") + " " + date.strftime("%p").downcase}

