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

ActiveRecord::Schema.define(version: 20150319175821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armor_instances", force: true do |t|
    t.integer  "vault_hunter_id"
    t.integer  "armor_template_id"
    t.integer  "modifier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "armor_templates", force: true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "deflect"
    t.integer  "cost"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumable_instances", force: true do |t|
    t.integer  "consumable_template_id"
    t.integer  "vault_hunter_id"
    t.integer  "modifier_id"
    t.integer  "current_uses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumable_templates", force: true do |t|
    t.string   "name"
    t.integer  "cost"
    t.integer  "max_uses"
    t.text     "description"
    t.integer  "modifier_id"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "durations", force: true do |t|
    t.integer  "max_time"
    t.integer  "current_time"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "effects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "modifier_id"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gear_instances", force: true do |t|
    t.integer  "vault_hunter_id"
    t.integer  "modifier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gear_templates", force: true do |t|
    t.string   "name"
    t.integer  "cost"
    t.text     "description"
    t.integer  "modifier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "melee_weapon_instances", force: true do |t|
    t.integer  "melee_weapon_template_id"
    t.string   "prefix"
    t.string   "postfix"
    t.integer  "current_recoil"
    t.text     "notes"
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "melee_weapon_templates", force: true do |t|
    t.string   "name"
    t.integer  "accuracy"
    t.integer  "recoil"
    t.integer  "damage"
    t.integer  "cost"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "minions", force: true do |t|
    t.integer  "vault_hunter_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hp"
    t.integer  "max_hp"
    t.integer  "armor"
    t.integer  "max_armor"
    t.integer  "shield"
    t.integer  "max_shield"
  end

  create_table "modifiers", force: true do |t|
    t.integer  "skill_id"
    t.integer  "perk_id"
    t.integer  "gear_instance_id"
    t.integer  "consumable_instance_id"
    t.integer  "ranged_weapon_instance_id"
    t.integer  "melee_weapon_instance_id"
    t.string   "name"
    t.string   "target"
    t.integer  "amount"
    t.integer  "duration_id"
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

  create_table "ranged_weapon_instances", force: true do |t|
    t.integer  "ranged_weapon_template_id"
    t.integer  "ammunition"
    t.text     "notes"
    t.string   "prefix"
    t.string   "postfix"
    t.integer  "current_recoil"
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranged_weapon_templates", force: true do |t|
    t.string   "name"
    t.integer  "accuracy"
    t.integer  "recoil"
    t.integer  "range"
    t.integer  "fire_mode"
    t.integer  "damage"
    t.integer  "cost"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shield_instances", force: true do |t|
    t.integer  "vault_hunter_id"
    t.integer  "current_capacity"
    t.integer  "shield_template_id"
    t.boolean  "in_use"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shield_templates", force: true do |t|
    t.string   "name"
    t.integer  "capacity"
    t.integer  "recharge"
    t.integer  "deflect"
    t.integer  "cost"
    t.string   "description"
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deplete_effect_id"
  end

  create_table "skill_instances", force: true do |t|
    t.integer  "skill_template_id"
    t.integer  "vault_hunter_id"
    t.integer  "level_acquired"
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
    t.integer  "cost"
  end

  create_table "skills", force: true do |t|
    t.integer  "skill_template_id"
    t.integer  "vault_hunter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stack_instances", force: true do |t|
    t.integer  "stack_template_id"
    t.integer  "current_pool"
    t.integer  "max_pool"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stack_templates", force: true do |t|
    t.string   "name"
    t.integer  "default_pool"
    t.integer  "color"
    t.string   "icon"
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
    t.text     "loot"
    t.integer  "money"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "background"
    t.text     "traits"
    t.text     "flaws"
    t.integer  "race_id"
    t.integer  "misc_atk_bonus"
    t.integer  "misc_ranged_atk_bonus"
    t.integer  "misc_melee_atk_bonus"
    t.integer  "misc_dmg_bonus"
    t.integer  "misc_ranged_dmg_bonus"
    t.integer  "misc_melee_dmg_bonus"
    t.integer  "current_initiative"
  end

end
