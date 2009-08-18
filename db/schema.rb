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

ActiveRecord::Schema.define(:version => 20090818032931) do

  create_table "alerts", :primary_key => "alert_id", :force => true do |t|
    t.string   "email",                           :default => "",    :null => false
    t.string   "criteria",                        :default => "",    :null => false
    t.boolean  "deleted",                         :default => false, :null => false
    t.string   "registrationtoken", :limit => 34, :default => "",    :null => false
    t.boolean  "confirmed",                       :default => false, :null => false
    t.datetime "created",                                            :null => false
  end

  add_index "alerts", ["confirmed", "deleted"], :name => "confirmed"
  add_index "alerts", ["email"], :name => "email"

  create_table "bills", :force => true do |t|
    t.string  "title",                        :default => "",    :null => false
    t.string  "url",                          :default => "",    :null => false
    t.boolean "lords",                        :default => false, :null => false
    t.string  "session",        :limit => 50, :default => "",    :null => false
    t.string  "standingprefix",               :default => "",    :null => false
  end

  add_index "bills", ["title"], :name => "title"

  create_table "consinfo", :id => false, :force => true do |t|
    t.string "constituency", :limit => 100, :default => "", :null => false
    t.string "data_key",     :limit => 100, :default => "", :null => false
    t.text   "data_value",                                  :null => false
  end

  add_index "consinfo", ["constituency", "data_key"], :name => "consinfo_constituency_data_key", :unique => true
  add_index "consinfo", ["constituency"], :name => "constituency"

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

  create_table "memberinfo", :id => false, :force => true do |t|
    t.integer   "member_id",                 :default => 0,  :null => false
    t.string    "data_key",   :limit => 100, :default => "", :null => false
    t.text      "data_value",                                :null => false
    t.timestamp "lastupdate",                                :null => false
  end

  add_index "memberinfo", ["member_id", "data_key"], :name => "memberinfo_member_id_data_key", :unique => true
  add_index "memberinfo", ["member_id"], :name => "member_id"

  create_table "moffice", :primary_key => "moffice_id", :force => true do |t|
    t.string  "dept",      :limit => 100, :default => "",           :null => false
    t.string  "position",  :limit => 200, :default => "",           :null => false
    t.date    "from_date",                :default => '1000-01-01', :null => false
    t.date    "to_date",                  :default => '9999-12-31', :null => false
    t.integer "person"
    t.string  "source",                   :default => "",           :null => false
  end

  add_index "moffice", ["person"], :name => "person"

  create_table "pbc_members", :force => true do |t|
    t.integer "member_id",              :default => 0,     :null => false
    t.boolean "chairman",               :default => false, :null => false
    t.integer "bill_id",                :default => 0,     :null => false
    t.string  "sitting",   :limit => 4, :default => "",    :null => false
    t.boolean "attending",              :default => false, :null => false
  end

  add_index "pbc_members", ["bill_id"], :name => "bill_id"
  add_index "pbc_members", ["member_id"], :name => "member_id"

  create_table "personinfo", :id => false, :force => true do |t|
    t.integer   "person_id",                 :default => 0,  :null => false
    t.string    "data_key",   :limit => 100, :default => "", :null => false
    t.text      "data_value",                                :null => false
    t.timestamp "lastupdate",                                :null => false
  end

  add_index "personinfo", ["person_id", "data_key"], :name => "personinfo_person_id_data_key", :unique => true
  add_index "personinfo", ["person_id"], :name => "person_id"

end
