class User < ActiveRecord::Base
  set_primary_key 'user_id'
  
  def name
    "#{firstname} #{lastname}"
  end
end
