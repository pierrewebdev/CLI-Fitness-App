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

ActiveRecord::Schema.define(version: 2020_08_20_030756) do

  create_table "exercise_logs", force: :cascade do |t|
    t.datetime "date_and_time"
    t.integer "lifter_id"
    t.integer "exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "target_muscle_group"
    t.integer "weight_in_pounds"
    t.integer "reps"
  end

  create_table "lifters", force: :cascade do |t|
    t.string "name"
  end

  create_table "personal_records", force: :cascade do |t|
    t.integer "max_rep_count"
    t.integer "max_weight"
    t.integer "exercise_log_id"
  end

end
