class Member < ActiveRecord::Base
  set_table_name "member"
  set_primary_key "member_id"
  has_many :minister_offices, :foreign_key => "person", :primary_key => "person_id"
  has_many :person_infos, :foreign_key => "person_id", :primary_key => "person_id"

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
  
  # Lookup up arbitrary person info stored in the db based on the key
  # returns nil if it doesn't exist
  def person_info_value(key)
    r = person_infos.find_by_data_key(key)
    r.data_value if r
  end
  
  def debate_sections_spoken_in_last_year
    person_info_value("debate_sectionsspoken_inlastyear")
  end
  
  def comments_on_speeches
    person_info_value("comments_on_speeches")
  end
  
  def reading_age_range
    text = person_info_value("reading_year")
    "#{text.to_f.round + 4}&ndash;#{text.to_f.round + 5}" if text
  end
  
  def three_word_alliterations
    person_info_value("three_word_alliterations")
  end
  
  def three_word_alliteration_content
    person_info_value("three_word_alliteration_content")
  end
  
  def mp_website
    person_info_value("mp_website")
  end
  
  def mp_biography_qanda
    person_info_value("mp_biography_qanda")
  end
  
  def mp_contact_details
    person_info_value("mp_contactdetails")
  end
  
  def mp_twitter_invite_tweetmp
    person_info_value("mp_twitter_invite_tweetmp")
  end
end
