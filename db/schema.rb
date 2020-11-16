# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_16_064803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "headquarters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hq_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "role", default: "member", null: false
    t.datetime "join_date"
    t.boolean "invitation_accepted", default: true, null: false
    t.uuid "user_id", null: false
    t.uuid "headquarter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["headquarter_id"], name: "index_hq_memberships_on_headquarter_id"
    t.index ["role", "invitation_accepted"], name: "index_hq_memberships_on_role_and_invitation_accepted"
    t.index ["user_id"], name: "index_hq_memberships_on_user_id"
  end

  create_table "project_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "job_title"
    t.datetime "join_date"
    t.boolean "invitation_accepted", default: true, null: false
    t.uuid "user_id", null: false
    t.uuid "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invitation_accepted"], name: "index_project_memberships_on_invitation_accepted"
    t.index ["project_id"], name: "index_project_memberships_on_project_id"
    t.index ["user_id"], name: "index_project_memberships_on_user_id"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "subdomain", null: false
    t.text "description"
    t.uuid "headquarter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["headquarter_id"], name: "index_projects_on_headquarter_id"
    t.index ["subdomain"], name: "index_projects_on_subdomain"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "auth_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email", "auth_token"], name: "index_users_on_email_and_auth_token"
  end

  add_foreign_key "hq_memberships", "headquarters"
  add_foreign_key "hq_memberships", "users"
  add_foreign_key "project_memberships", "projects"
  add_foreign_key "project_memberships", "users"
  add_foreign_key "projects", "headquarters"
end
