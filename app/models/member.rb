class Member < ActiveRecord::Base
  set_table_name "member"
  
  def name
    first_name + " " + last_name
  end
end
