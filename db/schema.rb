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

ActiveRecord::Schema.define(version: 2021_07_27_225731) do

  create_table "artworks", force: :cascade do |t|
    t.string "title"
    t.integer "edition"
    t.integer "likes"
    t.float "price"
    t.text "medium"
    t.text "image"
    t.boolean "featured"
    t.integer "date_created"
    t.integer "category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "popularity"
  end

  create_table "collections", force: :cascade do |t|
    t.integer "artwork_id"
    t.integer "collector_id"
  end

  create_table "collectors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "full_address"
    t.string "phone_num"
  end

end
