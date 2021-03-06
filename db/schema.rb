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

ActiveRecord::Schema.define(version: 2018_11_17_041441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charts", force: :cascade do |t|
    t.integer "user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "chart_id"
  end

  create_table "submission_details", force: :cascade do |t|
    t.integer "chart_id"
    t.integer "submission_id"
    t.integer "item_id"
    t.boolean "checked"
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "score"
    t.integer "chart_id"
    t.date "date"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
