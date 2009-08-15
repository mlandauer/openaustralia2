# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090815125449) do

  create_table "member", :primary_key => "member_id", :force => true do |t|
    t.integer   "house"
    t.string    "first_name",     :limit => 100
    t.string    "last_name",                     :default => "",           :null => false
    t.string    "constituency",   :limit => 100, :default => "",           :null => false
    t.string    "party",          :limit => 100, :default => "",           :null => false
    t.date      "entered_house",                 :default => '1000-01-01', :null => false
    t.date      "left_house",                    :default => '9999-12-31', :null => false
    t.string    "entered_reason", :limit => 30,  :default => "unknown",    :null => false
    t.string    "left_reason",    :limit => 30,  :default => "unknown",    :null => false
    t.integer   "person_id",                     :default => 0,            :null => false
    t.string    "title",          :limit => 50,  :default => "",           :null => false
    t.timestamp "lastupdate",                                              :null => false
  end

  add_index "member", ["constituency"], :name => "constituency"
  add_index "member", ["first_name", "last_name", "constituency", "entered_house", "left_house"], :name => "first_name", :unique => true
  add_index "member", ["house"], :name => "house"
  add_index "member", ["left_house", "house"], :name => "left_house_house"
  add_index "member", ["person_id"], :name => "person_id"

end
