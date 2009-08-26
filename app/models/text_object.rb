class TextObject < ActiveRecord::Base
  set_table_name "epobject"
  # Disabling inheritance_column because we are using "type" as a column name
  # TODO: rename "type" column to something else
  self.inheritance_column = nil
end
