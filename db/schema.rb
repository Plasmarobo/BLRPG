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

ActiveRecord::Schema.define(version: 20141108014617) do

  create_table "attacks", force: true do |t|
    t.string   "name"
    t.integer  "pool"
    t.integer  "dmg"
    t.string   "misc"
    t.integer  "vault_hunter_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attribute_instances", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.string   "short"
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attribute_templates", force: true do |t|
    t.string   "name"
    t.string   "short"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attributes", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.string   "short"
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prerequsites", force: true do |t|
    t.integer  "skill_template_id"
    t.string   "prereq_type"
    t.string   "prereq_name"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proficiencies", force: true do |t|
    t.string   "name"
    t.integer  "pool"
    t.integer  "points"
    t.string   "attribute_name"
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proficiency_templates", force: true do |t|
    t.string   "name"
    t.string   "attribute_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_templates", force: true do |t|
    t.string   "name"
    t.string   "skill_type"
    t.integer  "cooldown"
    t.integer  "duration"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "skill_template_id"
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   :confirmation_token
    t.datetime :confirmed_at
    t.datetime :confirmation_sent_at
    t.string   :unconfirmed_email
    t.integer  :failed_attempts, :default => 0
    t.string   :unlock_token
    t.datetime :locked_at
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "vault_hunters", force: true do |t|
    t.string   "name"
    t.string   "user_id"
    t.integer  "age"
    t.string   "race"
    t.integer  "height"
    t.integer  "weight"
    t.integer  "toughness"
    t.integer  "wounds"
    t.integer  "shield"
    t.integer  "current_shield"
    t.text     "loot"
    t.integer  "money"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
