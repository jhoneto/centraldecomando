# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120102180401) do

  create_table "accounts", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "charts", :force => true do |t|
    t.string   "name",       :limit => 100,                    :null => false
    t.integer  "account_id",                                   :null => false
    t.integer  "chart_type",                                   :null => false
    t.string   "model",      :limit => 50,                     :null => false
    t.string   "params",     :limit => 500
    t.string   "method",     :limit => 50,                     :null => false
    t.integer  "user_id",                                      :null => false
    t.boolean  "show",                      :default => false, :null => false
    t.boolean  "sidebar",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "account_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "comment_type", :null => false
    t.text     "comment",      :null => false
    t.integer  "user_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "process_id",   :null => false
  end

  create_table "filters", :force => true do |t|
    t.string   "name",       :limit => 50,                      :null => false
    t.string   "model",      :limit => 100,                     :null => false
    t.integer  "user_id",                                       :null => false
    t.string   "where",      :limit => 500,                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "columns",    :limit => 1000
    t.boolean  "show",                       :default => false
  end

  create_table "project_members", :force => true do |t|
    t.integer  "project_id",                               :null => false
    t.integer  "user_id",                                  :null => false
    t.integer  "role",                                     :null => false
    t.decimal  "week_hours", :precision => 5, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name",             :null => false
    t.integer  "account_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "qty_sprint_days"
    t.integer  "start_sprint"
    t.boolean  "include_saturday"
    t.boolean  "include_sunday"
  end

  create_table "sprints", :force => true do |t|
    t.integer  "project_id",        :null => false
    t.string   "sequence",          :null => false
    t.date     "date_of_beginning", :null => false
    t.date     "date_of_end",       :null => false
    t.integer  "status",            :null => false
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.string   "as_a",       :limit => 100, :null => false
    t.text     "i_want_to",                 :null => false
    t.text     "so_that_i"
    t.integer  "project_id",                :null => false
    t.integer  "complexity"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.text     "acceptance"
  end

  create_table "stories_sprints", :force => true do |t|
    t.integer  "story_id",                      :null => false
    t.integer  "sprint_id",                     :null => false
    t.boolean  "closed",     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_status", :force => true do |t|
    t.string   "name",            :limit => 100,                    :null => false
    t.integer  "account_id",                                        :null => false
    t.boolean  "first",                          :default => false, :null => false
    t.boolean  "final",                          :default => false, :null => false
    t.integer  "status_prior_id"
    t.integer  "status_next_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "initial"
  end

  create_table "ticket_types", :force => true do |t|
    t.string   "name",       :limit => 30, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.string   "title",                :limit => 500, :null => false
    t.text     "description"
    t.integer  "project_id"
    t.integer  "client_id"
    t.date     "date_of_registration",                :null => false
    t.date     "cancellation_date"
    t.date     "closing_date"
    t.integer  "user_registration_id"
    t.integer  "user_owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.integer  "ticket_type_id"
    t.integer  "ticket_status_id"
    t.string   "solicitant",           :limit => 100
  end

  create_table "tickets_sprints", :force => true do |t|
    t.integer  "ticket_id",                                                   :null => false
    t.integer  "sprint_id",                                                   :null => false
    t.boolean  "closed",                                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "estimate",   :precision => 5, :scale => 2
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id",                               :null => false
    t.integer  "number_columns_portlet", :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "name"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.boolean  "admin",                             :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
