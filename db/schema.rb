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

ActiveRecord::Schema.define(version: 20141203185500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attacks", force: true do |t|
    t.string   "name"
    t.integer  "totalpool"
    t.integer  "dmg"
    t.string   "misc"
    t.integer  "vault_hunter_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "basepool"
    t.integer  "attribute_instance_id"
    t.integer  "otherpool"
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

  create_table "minions", force: true do |t|
    t.integer  "vault_hunter_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "perks", force: true do |t|
    t.integer  "race_id"
    t.text     "description"
    t.string   "perk_type"
    t.string   "name"
    t.integer  "value"
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
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tier"
    t.integer  "proficiency_template_id"
  end

  create_table "proficiency_templates", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skill_templates", force: true do |t|
    t.string   "name"
    t.string   "skill_type"
    t.integer  "cooldown"
    t.integer  "duration"
    t.text     "description"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "vault_hunters", force: true do |t|
    t.string   "name"
    t.string   "user_id"
    t.integer  "age"
    t.string   "height"
    t.string   "weight"
    t.integer  "toughness"
    t.integer  "wounds"
    t.integer  "shield"
    t.integer  "current_shield"
    t.text     "loot"
    t.integer  "money"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "spent_proficiency_points"
    t.integer  "spent_skill_points"
    t.text     "description"
    t.text     "background"
    t.text     "traits"
    t.text     "flaws"
    t.integer  "total_attribute_points"
    t.integer  "total_proficiency_points"
    t.integer  "total_skill_points"
    t.integer  "spent_attribute_points"
    t.integer  "race_id"
  end

end
