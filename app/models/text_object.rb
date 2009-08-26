require 'Hpricot'

class TextObject < ActiveRecord::Base
  set_table_name "epobject"
  # Disabling inheritance_column because we are using "type" as a column name
  # TODO: rename "type" column to something else
  self.inheritance_column = nil
  
  # Process body so that it can be displayed
  def display_body
    doc = Hpricot(body)
    # Make all links 'nofollow'
    (doc/'a').each {|a| a["rel"] = "nofollow"}
    doc.to_s
  end
end
