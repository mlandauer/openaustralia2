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

ActiveRecord::Schema.define(:version => 20090821100605) do

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

  create_table "comments", :primary_key => "comment_id", :force => true do |t|
    t.integer  "user_id",                    :default => 0,     :null => false
    t.integer  "epobject_id",                :default => 0,     :null => false
    t.text     "body"
    t.datetime "posted"
    t.datetime "modflagged"
    t.boolean  "visible",                    :default => false, :null => false
    t.string   "original_gid", :limit => 60
  end

  add_index "comments", ["epobject_id", "visible"], :name => "epobject_id"
  add_index "comments", ["user_id", "epobject_id", "visible"], :name => "user_id"
  add_index "comments", ["visible"], :name => "visible"

  create_table "consinfo", :id => false, :force => true do |t|
    t.string "constituency", :limit => 100, :default => "", :null => false
    t.string "data_key",     :limit => 100, :default => "", :null => false
    t.text   "data_value",                                  :null => false
  end

  add_index "consinfo", ["constituency", "data_key"], :name => "consinfo_constituency_data_key", :unique => true
  add_index "consinfo", ["constituency"], :name => "constituency"

  create_table "editqueue", :primary_key => "edit_id", :force => true do |t|
    t.integer  "user_id"
    t.integer  "edit_type"
    t.integer  "epobject_id_l"
    t.integer  "epobject_id_h"
    t.integer  "glossary_id"
    t.datetime "time_start"
    t.datetime "time_end"
    t.string   "title"
    t.text     "body"
    t.datetime "submitted"
    t.integer  "editor_id"
    t.boolean  "approved"
    t.datetime "decided"
    t.string   "reason"
  end

  add_index "editqueue", ["approved"], :name => "approved"
  add_index "editqueue", ["glossary_id"], :name => "glossary_id"

  create_table "epobject", :primary_key => "epobject_id", :force => true do |t|
    t.string   "title"
    t.text     "body",     :limit => 16777215
    t.integer  "type"
    t.datetime "created"
    t.datetime "modified"
  end

  add_index "epobject", ["type"], :name => "type"

  create_table "gidredirect", :id => false, :force => true do |t|
    t.string  "gid_from", :limit => 60
    t.string  "gid_to",   :limit => 60
    t.date    "hdate",                  :null => false
    t.integer "major"
  end

  add_index "gidredirect", ["gid_from"], :name => "gid_from", :unique => true
  add_index "gidredirect", ["gid_to"], :name => "gid_to"

  create_table "glossary", :primary_key => "glossary_id", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "wikipedia"
    t.datetime "created"
    t.datetime "last_modified"
    t.integer  "type"
    t.integer  "visible",       :limit => 1
  end

  add_index "glossary", ["visible"], :name => "visible"

  create_table "hansard", :primary_key => "epobject_id", :force => true do |t|
    t.string   "gid",           :limit => 100
    t.integer  "htype",                        :default => 0,  :null => false
    t.integer  "speaker_id",                   :default => 0,  :null => false
    t.integer  "major",                        :default => 0,  :null => false
    t.integer  "section_id",                   :default => 0,  :null => false
    t.integer  "subsection_id",                :default => 0,  :null => false
    t.integer  "hpos",                         :default => 0,  :null => false
    t.date     "hdate",                                        :null => false
    t.time     "htime"
    t.string   "source_url",                   :default => "", :null => false
    t.integer  "minor"
    t.datetime "created"
    t.datetime "modified"
  end

  add_index "hansard", ["epobject_id"], :name => "epobject_id"
  add_index "hansard", ["gid"], :name => "gid", :unique => true
  add_index "hansard", ["hdate"], :name => "hdate"
  add_index "hansard", ["htype"], :name => "htype"
  add_index "hansard", ["major", "hdate"], :name => "majorhdate"
  add_index "hansard", ["major"], :name => "major"
  add_index "hansard", ["modified"], :name => "modified"
  add_index "hansard", ["section_id"], :name => "section_id"
  add_index "hansard", ["source_url"], :name => "source_url"
  add_index "hansard", ["speaker_id", "hdate", "hpos"], :name => "hansard_speaker_id_hdate_hpos"
  add_index "hansard", ["speaker_id"], :name => "speaker_id"
  add_index "hansard", ["subsection_id"], :name => "subsection_id"

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

  create_table "titles", :primary_key => "title", :force => true do |t|
  end

  create_table "users", :primary_key => "user_id", :force => true do |t|
    t.string   "firstname",                       :default => "",       :null => false
    t.string   "lastname",                        :default => "",       :null => false
    t.string   "email",                           :default => "",       :null => false
    t.string   "password",          :limit => 34, :default => "",       :null => false
    t.datetime "lastvisit",                                             :null => false
    t.datetime "registrationtime",                                      :null => false
    t.string   "registrationip",    :limit => 20
    t.string   "status",            :limit => 15, :default => "Viewer"
    t.boolean  "emailpublic",                     :default => false,    :null => false
    t.boolean  "optin",                           :default => false,    :null => false
    t.boolean  "deleted",                         :default => false,    :null => false
    t.string   "constituency",                    :default => "",       :null => false
    t.string   "registrationtoken", :limit => 24, :default => "",       :null => false
    t.boolean  "confirmed",                       :default => false,    :null => false
    t.string   "url",                             :default => "",       :null => false
    t.string   "api_key",           :limit => 24
  end

  add_index "users", ["api_key"], :name => "api_key", :unique => true
  add_index "users", ["email"], :name => "email"

end
