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

ActiveRecord::Schema.define(version: 20171114165614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", id: :string, force: :cascade do |t|
    t.string "hit_id", null: false
    t.string "turk_submit_to", null: false
    t.string "worker_id", null: false
    t.integer "classification_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credentials", force: :cascade do |t|
    t.text "token", null: false
    t.string "refresh"
    t.datetime "expires_at", null: false
    t.integer "project_ids", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_credentials_on_token", unique: true
  end

  create_table "hits", id: :string, force: :cascade do |t|
    t.string "hit_type_id"
    t.string "hit_group_id"
    t.integer "workflow_id"
    t.integer "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workflow_subjects", force: :cascade do |t|
    t.bigint "workflow_id", null: false
    t.integer "subject_id", null: false
    t.datetime "finished_at"
    t.index ["workflow_id"], name: "index_workflow_subjects_on_workflow_id"
  end

  create_table "workflows", force: :cascade do |t|
    t.integer "project_id", null: false
  end

  add_foreign_key "workflow_subjects", "workflows"
end
