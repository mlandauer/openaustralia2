class Hansard < ActiveRecord::Base
  set_table_name "hansard"
  belongs_to :text_object, :foreign_key => "epobject_id", :primary_key => "epobject_id"

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
end
