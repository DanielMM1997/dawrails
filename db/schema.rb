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

ActiveRecord::Schema.define(version: 2021_01_12_122954) do

  create_table "background_categories", force: :cascade do |t|
    t.integer "background_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["background_id"], name: "index_background_categories_on_background_id"
    t.index ["category_id"], name: "index_background_categories_on_category_id"
  end

  create_table "backgrounds", force: :cascade do |t|
    t.string "title"
    t.string "path"
    t.string "tags"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "author_id"
    t.index ["author_id"], name: "index_backgrounds_on_author_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "background_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["background_id", "user_id"], name: "index_likes_on_background_id_and_user_id", unique: true
    t.index ["background_id"], name: "index_likes_on_background_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "email"
    t.string "password"
    t.integer "type", default: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "background_categories", "backgrounds"
  add_foreign_key "background_categories", "categories"
  add_foreign_key "backgrounds", "users", column: "author_id"
  add_foreign_key "likes", "backgrounds"
  add_foreign_key "likes", "users"
end
