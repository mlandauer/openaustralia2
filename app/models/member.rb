class Member < ActiveRecord::Base
  set_table_name "member"
  set_primary_key "member_id"
  has_many :minister_offices, :foreign_key => "person", :primary_key => "person_id"

  def name
    first_name + " " + last_name
  end
  
  def current_minister_positions
    current_minister_offices.map{|o| o.position}
  end
  
  def current_minister_offices
    minister_offices.find_all{|m| m.current?}
  end

  def non_current_minister_offices
    minister_offices.find_all{|m| !m.current?}
  end
  
  def entered_reason_text
    case entered_reason
    when "general_election"
      "General election"
    when "by_election"
      "Byelection"
    when "unknown"
      "unknown"
    else
      throw "Unsupported value '#{entered_reason}'for 'entered_reason'"
    end
  end
  
  def representative?
    house == 1
  end
  
  def senator?
    house == 2
  end
  
  def formal_name
    if representative?
      "#{name} MP"
    elsif senator?
      "Senator #{name}"
    else
      throw "Unknown house"
    end
  end
  
  def generic_reference
    if representative?
      "Representative"
    elsif senator?
      "Senator"
    else
      throw "Unknown house"
    end
  end
end
