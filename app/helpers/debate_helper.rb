module DebateHelper
  def calendar(year, month, current_date, recess, linked)
    b = Builder::XmlMarkup.new
    b.div(:class => "calendar") do
      b.table(:border => 0) do
        b.caption "#{Date::MONTHNAMES[month]} #{year}"
        b.thead do
          b.tr do
            (1..7).each do |day|
              b.th Date::ABBR_DAYNAMES[day.modulo(7)]
            end
          end
        end
        b.tbody do
          # The day of the week for the first day of the month (Monday is 0)
          day_first_of_month = (Date.new(year, month, 1).wday - 1).modulo(7)
          if month == 12
            no_days_in_month = (Date.new(year + 1, 1, 1) - 1).mday
          else
            no_days_in_month = (Date.new(year, month + 1, 1) - 1).mday
          end
          current_day = 1 - day_first_of_month

          while current_day <= no_days_in_month do
            b.tr do
              if current_day < 1
                b.td({:colspan => day_first_of_month}) { b << "&nbsp;" }
              end
              (current_day..(current_day + 6)).each do |day|
                if day > 0 && Date.valid_date?(year, month, day)
                  date = Date.new(year, month, day)
                  if recess.find {|r| r.include?(date)}
                    atts = {:title => "recess", :class => "no"}
                  else
                    atts = {}
                  end
                  if block_given?
                    url = yield(date)
                  else
                    url = representatives_debate_path(:d => date)
                  end
                  atts.merge!(:class => "on") if date == current_date
                  if linked.include?(date) && date != current_date
                    b.td(atts) { b.a({:href => url}, day) }
                  else
                    b.td(atts, day)
                  end
                end
              end
              if current_day > 0 && !Date.valid_date?(year, month, current_day + 6)
                b.td(:colspan => (6 - no_days_in_month + current_day)) { b << "&nbsp;" }
              end
            end
            current_day += 7
          end
        end
      end
    end
    b << "<!-- end calendar -->"
  end
end
