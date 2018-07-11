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

ActiveRecord::Schema.define(version: 2018_07_10_153742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "films", force: :cascade do |t|
    t.integer "film_id"
    t.string "title"
    t.integer "episode_id"
    t.string "opening_crawl"
    t.string "director"
    t.string "producer"
    t.date "release_date"
    t.text "species", default: [], array: true
    t.text "starships", default: [], array: true
    t.text "vehicles", default: [], array: true
    t.text "characters", default: [], array: true
    t.text "planets", default: [], array: true
    t.string "url"
    t.string "created"
    t.string "edited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_caches", force: :cascade do |t|
    t.string "url"
    t.string "previous"
    t.string "next"
    t.text "ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_page_caches_on_url"
  end

  create_table "people", force: :cascade do |t|
    t.integer "person_id"
    t.string "name"
    t.string "birth_year"
    t.string "eye_color"
    t.string "gender"
    t.string "hair_color"
    t.string "height"
    t.string "mass"
    t.string "skin_color"
    t.string "homeworld"
    t.text "films", default: [], array: true
    t.text "species", default: [], array: true
    t.text "starships", default: [], array: true
    t.text "vehicles", default: [], array: true
    t.string "url"
    t.string "created"
    t.string "edited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_people_on_person_id"
  end

  create_table "planets", force: :cascade do |t|
    t.integer "planet_id"
    t.string "name"
    t.string "diameter"
    t.string "rotation_period"
    t.string "orbital_period"
    t.string "gravity"
    t.string "population"
    t.string "climate"
    t.string "terrain"
    t.string "surface_water"
    t.text "residents", default: [], array: true
    t.text "films", default: [], array: true
    t.string "url"
    t.string "created"
    t.string "edited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "species", force: :cascade do |t|
    t.integer "species_id"
    t.string "name"
    t.string "classification"
    t.string "designation"
    t.string "average_height"
    t.string "average_lifespan"
    t.string "eye_colors"
    t.string "hair_colors"
    t.string "skin_colors"
    t.string "language"
    t.string "homeworld"
    t.text "people", default: [], array: true
    t.text "films", default: [], array: true
    t.string "url"
    t.string "created"
    t.string "edited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "starships", force: :cascade do |t|
    t.integer "starship_id"
    t.string "model"
    t.string "starship_class"
    t.string "manufacturer"
    t.string "cost_in_credits"
    t.string "length"
    t.string "crew"
    t.string "passengers"
    t.string "max_atmosphering_speed"
    t.string "hyperdrive_rating"
    t.string "mglt"
    t.string "cargo_capacity"
    t.string "consumables"
    t.text "films", default: [], array: true
    t.text "pilots", default: [], array: true
    t.string "url"
    t.string "created"
    t.string "edited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer "vehicle_id"
    t.string "name"
    t.string "model"
    t.string "vehicle_class"
    t.string "manufacturer"
    t.string "length"
    t.string "cost_in_credits"
    t.string "crew"
    t.string "passengers"
    t.string "max_atmosphering_speed"
    t.string "cargo_capacity"
    t.string "consumables"
    t.text "films", default: [], array: true
    t.text "pilots", default: [], array: true
    t.string "url"
    t.string "created"
    t.string "edited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
