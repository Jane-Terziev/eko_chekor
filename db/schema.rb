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

ActiveRecord::Schema.define(version: 2020_11_01_044522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "garbages", force: :cascade do |t|
    t.string "description"
    t.bigint "user_id"
    t.integer "points"
    t.integer "status"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cleaner_id"
    t.integer "reviewer_id"
    t.string "image_cleaned"
    t.index ["user_id"], name: "index_garbages_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.decimal "longitude"
    t.decimal "latitude"
    t.integer "locationable_id"
    t.string "locationable_type"
  end

  create_table "tests", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.index ["email"], name: "index_unique_email", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "garbages", "users", column: "cleaner_id"
  add_foreign_key "garbages", "users", column: "reviewer_id"
end
