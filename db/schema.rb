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

ActiveRecord::Schema.define(version: 2021_07_07_071141) do

  create_table "blogs", charset: "utf8mb4", comment: "ブログ", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "title", null: false, comment: "タイトル"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_blogs_on_employee_id"
  end

  create_table "companies", charset: "utf8mb4", comment: "会社", force: :cascade do |t|
    t.string "name", null: false, comment: "会社名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "employee_authenticates", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_employee_authenticates_on_confirmation_token", unique: true
    t.index ["email"], name: "index_employee_authenticates_on_email", unique: true
    t.index ["employee_id"], name: "index_employee_authenticates_on_employee_id", unique: true
    t.index ["reset_password_token"], name: "index_employee_authenticates_on_reset_password_token", unique: true
  end

  create_table "employee_profiles", charset: "utf8mb4", comment: "従業員プロフィール", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "name", null: false, comment: "名前"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_employee_profiles_on_employee_id", unique: true
  end

  create_table "employees", charset: "utf8mb4", comment: "従業員", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flipper_features", charset: "utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", charset: "utf8mb4", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "left_employees", charset: "utf8mb4", comment: "退会した従業員", force: :cascade do |t|
    t.bigint "employee_id"
    t.string "email", default: "", null: false, comment: "emailアドレス"
    t.string "name", default: "", null: false, comment: "従業員名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_left_employees_on_employee_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "blogs", "employees"
  add_foreign_key "employee_authenticates", "employees"
  add_foreign_key "employee_profiles", "employees"
  add_foreign_key "left_employees", "employees"
end
