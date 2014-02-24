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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140223174549) do

  create_table "access_token_profiles", force: true do |t|
    t.string   "access_token",                  limit: 128, null: false
    t.string   "access_token_type",                         null: false
    t.datetime "expiration_date",                           null: false
    t.string   "grant_type",                                null: false
    t.integer  "authorization_code_profile_id",             null: false
  end

  add_index "access_token_profiles", ["authorization_code_profile_id"], name: "index_access_token_profiles_on_authorization_code_profile_id", using: :btree

  create_table "access_token_profiles_to_scopes", id: false, force: true do |t|
    t.integer "token_id", null: false
    t.integer "scope_id", null: false
  end

  add_index "access_token_profiles_to_scopes", ["scope_id"], name: "index_access_token_profiles_to_scopes_on_scope_id", using: :btree
  add_index "access_token_profiles_to_scopes", ["token_id", "scope_id"], name: "index_tokens_to_scopes_on_token_id_and_scope_id", unique: true, using: :btree
  add_index "access_token_profiles_to_scopes", ["token_id"], name: "index_access_token_profiles_to_scopes_on_token_id", using: :btree

  create_table "authorization_code_profiles", force: true do |t|
    t.string   "authorization_code", limit: 128, null: false
    t.datetime "expiration_date",                null: false
    t.text     "redirection_uri",                null: false
    t.string   "response_type",                  null: false
    t.text     "state",                          null: false
    t.string   "client_id",          limit: 43,  null: false
  end

  add_index "authorization_code_profiles", ["client_id"], name: "index_authorization_code_profiles_on_client_id", using: :btree

  create_table "authorization_code_profiles_to_scopes", id: false, force: true do |t|
    t.integer "code_id",  null: false
    t.integer "scope_id", null: false
  end

  add_index "authorization_code_profiles_to_scopes", ["code_id", "scope_id"], name: "index_codes_to_scopes_on_code_id_and_scope_id", unique: true, using: :btree
  add_index "authorization_code_profiles_to_scopes", ["code_id"], name: "index_authorization_code_profiles_to_scopes_on_code_id", using: :btree
  add_index "authorization_code_profiles_to_scopes", ["scope_id"], name: "index_authorization_code_profiles_to_scopes_on_scope_id", using: :btree

  create_table "authorization_code_scopes", force: true do |t|
    t.string "title",       limit: 64, null: false
    t.text   "description",            null: false
  end

  create_table "users", force: true do |t|
    t.string  "email",                                   null: false
    t.text    "password",                                null: false
    t.text    "salt"
    t.string  "type"
    t.string  "app_title",       limit: 120
    t.string  "redirection_uri"
    t.integer "client_type",     limit: 2,   default: 1
  end

  add_index "users", ["redirection_uri"], name: "index_users_on_redirection_uri", unique: true, using: :btree

end
