module DebateHelper
  def calendar(year, month)
    b = Builder::XmlMarkup.new
    b.table do
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
        current_day = 1 - day_first_of_month

        while Date.valid_date?(year, month, current_day) do
          b.tr do
            b.td({:colspan => day_first_of_month}, "&nbsp;") if current_day < 1
            (current_day..(current_day + 6)).each do |day|
              b.td day if day > 0 && Date.valid_date?(year, month, day)
            end
          end
          current_day += 7
        end
      end
    end
  end
end
