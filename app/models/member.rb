class Member < ActiveRecord::Base
  set_table_name "member"
  set_primary_key "member_id"
  has_many :minister_offices, :foreign_key => "person", :primary_key => "person_id"

  def name
    first_name + " " + last_name
  end
  
  def current_minister_positions
    minister_offices.find_all{|m| m.current?}.map{|o| o.position}
  end
end
