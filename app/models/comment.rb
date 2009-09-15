class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :speech, :class_name => 'Hansard', :foreign_key => 'epobject_id'
  
  # Ah crap. It looks like the current php app stores dates in local time rather than UTC
  def posted
    # Will interpret the stored date as being in the timezone set in Time.zone
    Time.zone.parse(posted_before_type_cast)
  end
end
