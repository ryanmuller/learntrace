# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20140101190921) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["item_id"], :name => "index_comments_on_item_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "forks", :force => true do |t|
    t.integer  "source_id"
    t.integer  "target_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "forks", ["source_id", "target_id"], :name => "index_forks_on_source_id_and_target_id", :unique => true
  add_index "forks", ["source_id"], :name => "index_forks_on_source_id"
  add_index "forks", ["target_id"], :name => "index_forks_on_target_id"

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "pins_count",  :default => 0
    t.string   "thumb_url"
  end

  create_table "pins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "status",       :default => "todo"
    t.integer  "stream_id"
    t.datetime "scheduled_at"
    t.datetime "completed_at"
  end

  add_index "pins", ["item_id"], :name => "index_pins_on_item_id"
  add_index "pins", ["stream_id"], :name => "index_pins_on_stream_id"
  add_index "pins", ["user_id"], :name => "index_pins_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "streams", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "forks_count", :default => 0
    t.boolean  "public",      :default => true
    t.boolean  "featured",    :default => false, :null => false
  end

  add_index "streams", ["user_id"], :name => "index_paths_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "item_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["item_id"], :name => "index_taggings_on_item_id"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["user_id"], :name => "index_taggings_on_user_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "uid"
    t.string   "provider"
    t.string   "image"
    t.string   "name"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username"

end
