class MinisterOffice < ActiveRecord::Base
  set_table_name "moffice"
  
  def current?
    Date.today >= from_date && Date.today <= to_date
  end
end
