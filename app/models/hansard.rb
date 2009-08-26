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
end
