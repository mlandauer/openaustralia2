class Hansard < ActiveRecord::Base
  set_table_name "hansard"
  belongs_to :text_object, :foreign_key => "epobject_id", :primary_key => "epobject_id"
  belongs_to :speaker, :class_name => "Member"
  belongs_to :section, :class_name => "Hansard", :primary_key => "epobject_id"
  belongs_to :subsection, :class_name => "Hansard", :primary_key => "epobject_id"
  
  def section?
		htype == 10
	end
	
	def subsection?
		htype == 11
	end
	
	def speech?
		htype == 12
	end
	
	def procedural?
	  htype == 13
  end
  
  def Hansard.find_by_id(id)
    find_by_gid("uk.org.publicwhip/debate/#{id}")
  end
  
  def id
    if gid =~ /^uk.org.publicwhip\/debate\/(.*)/
      $~[1]
    else
      raise "Unexpected form for gid"
    end
  end
  
  # Anchor to identify this speech within a single day
  def anchor
    if gid =~ /^uk.org.publicwhip\/debate\/[^.]+\.(.*)/
      "g" + $~[1]
    else
      raise "Unexpected form for gid"
    end
  end
  
  def to_s
    text_object.body
  end
  
  def just_text
    Hpricot(text_object.body).inner_text
  end
  
  # Returns all speeches and procedurals in the given subsection
  def Hansard.speeches_in_subsection(subsection)
    all(:conditions => ['subsection_id = ?', subsection.epobject_id], :order => "hpos ASC")
  end
  
  def previous_speech_within_subsection
    Hansard.first(
      :conditions => ['hdate = ? AND hpos < ? AND subsection_id = ? AND (htype != 10 AND htype != 11)',
        hdate, hpos, subsection_id],
      :order => "hpos DESC")
  end  

  def next_speech_within_subsection
    Hansard.first(
      :conditions => ['hdate = ? AND hpos > ? AND subsection_id = ? AND (htype != 10 AND htype != 11)',
        hdate, hpos, subsection_id],
      :order => "hpos ASC")
  end
  
  def no_speeches
    if section?
      Hansard.count(:conditions => {:section_id => epobject_id, :subsection_id => 0, :htype => 12})
    elsif subsection?
      Hansard.count(:conditions => {:section_id => section_id, :subsection_id => epobject_id, :htype => 12})      
    else
      raise "Not yet supporting no_speeches for subsections"
    end
  end
end
