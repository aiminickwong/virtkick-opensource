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

ActiveRecord::Schema.define(version: 20141003233726) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "ip_ranges", force: true do |t|
    t.string  "netmask"
    t.string  "gateway"
    t.integer "hypervisor_id", default: 1
  end

  create_table "ips", force: true do |t|
    t.integer "ip_range_id"
    t.string  "ip"
    t.boolean "taken",       default: false
    t.string  "vm_uuid"
  end

  create_table "meta_machines", force: true do |t|
    t.string   "hostname"
    t.integer  "user_id"
    t.integer  "libvirt_hypervisor_id"
    t.string   "libvirt_machine_name"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "meta_machines", ["hostname"], name: "index_meta_machines_on_hostname", unique: true
  add_index "meta_machines", ["user_id"], name: "index_meta_machines_on_user_id"

  create_table "new_machines", force: true do |t|
    t.string   "hostname"
    t.integer  "user_id"
    t.integer  "plan_id"
    t.integer  "iso_distro_id"
    t.integer  "iso_image_id"
    t.string   "current_step",                default: "create_machine"
    t.boolean  "step_create_machine"
    t.boolean  "finished",                    default: false
    t.integer  "given_libvirt_hypervisor_id"
    t.string   "given_libvirt_machine_name"
    t.integer  "given_meta_machine_id"
    t.string   "error_message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "progresses", force: true do |t|
    t.integer  "user_id",                    null: false
    t.boolean  "finished",   default: false, null: false
    t.string   "error"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "progresses", ["user_id"], name: "index_progresses_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
