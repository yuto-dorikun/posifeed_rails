# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_08_18_123812) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "level", null: false
    t.bigint "parent_department_id"
    t.bigint "organization_id", null: false
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "level"], name: "index_departments_on_organization_id_and_level"
    t.index ["organization_id"], name: "index_departments_on_organization_id"
    t.index ["parent_department_id"], name: "index_departments_on_parent_department_id"
  end

  create_table "feedback_categories", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "emoji", limit: 10, null: false
    t.integer "points_value", null: false
    t.string "color", limit: 7, null: false
    t.integer "sort_order", default: 0
    t.boolean "is_active", default: true
    t.boolean "is_system_default", default: false, null: false
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "organization_id"], name: "index_feedback_categories_on_name_and_organization_id", unique: true
    t.index ["organization_id", "is_system_default"], name: "idx_on_organization_id_is_system_default_6efb88a03a"
    t.index ["organization_id"], name: "index_feedback_categories_on_organization_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.bigint "feedback_category_id", null: false
    t.text "message", null: false
    t.integer "points", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feedback_category_id"], name: "index_feedbacks_on_feedback_category_id"
    t.index ["receiver_id", "created_at"], name: "index_feedbacks_on_receiver_id_and_created_at"
    t.index ["receiver_id"], name: "index_feedbacks_on_receiver_id"
    t.index ["sender_id", "created_at"], name: "index_feedbacks_on_sender_id_and_created_at"
    t.index ["sender_id"], name: "index_feedbacks_on_sender_id"
    t.check_constraint "length(message) >= 10 AND length(message) <= 500", name: "check_message_length"
    t.check_constraint "sender_id <> receiver_id", name: "check_sender_not_receiver"
  end

  create_table "group_memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.string "role", default: "member", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "role"], name: "index_group_memberships_on_group_id_and_role"
    t.index ["group_id"], name: "index_group_memberships_on_group_id"
    t.index ["user_id", "group_id"], name: "index_group_memberships_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_group_memberships_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "is_active", default: true, null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "is_active"], name: "index_groups_on_organization_id_and_is_active"
    t.index ["organization_id"], name: "index_groups_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", limit: 200, null: false
    t.string "invite_code", limit: 8, null: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invite_code"], name: "index_organizations_on_invite_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.bigint "organization_id"
    t.bigint "department_id"
    t.integer "total_gratitude_points", default: 0
    t.boolean "is_active", default: true
    t.string "role", default: "member", null: false
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id", "role"], name: "index_users_on_organization_id_and_role"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "departments", "departments", column: "parent_department_id"
  add_foreign_key "departments", "organizations"
  add_foreign_key "feedback_categories", "organizations"
  add_foreign_key "feedbacks", "feedback_categories"
  add_foreign_key "feedbacks", "users", column: "receiver_id"
  add_foreign_key "feedbacks", "users", column: "sender_id"
  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "users"
  add_foreign_key "groups", "organizations"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "organizations"
end
