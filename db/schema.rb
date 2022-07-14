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

ActiveRecord::Schema[7.0].define(version: 2022_07_13_173552) do
  create_table "games", force: :cascade do |t|
    t.integer "number_of_players"
    t.integer "quests_passed"
    t.integer "quests_remaining"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "variant"
    t.integer "next_quest_number"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "team"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "veteran_status"
    t.boolean "leader_status"
    t.integer "left_pointee_id"
    t.integer "right_pointee_id"
    t.index ["left_pointee_id"], name: "index_players_on_left_pointee_id"
    t.index ["right_pointee_id"], name: "index_players_on_right_pointee_id"
  end

  create_table "quest_assignments", force: :cascade do |t|
    t.integer "quest_id"
    t.integer "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_quest_assignments_on_player_id"
    t.index ["quest_id"], name: "index_quest_assignments_on_quest_id"
  end

  create_table "quests", force: :cascade do |t|
    t.integer "quest_order"
    t.integer "number_of_participants"
    t.integer "number_of_failures"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_passes"
    t.integer "leader_id"
    t.integer "token_holder_id"
    t.index ["leader_id"], name: "index_quests_on_leader_id"
    t.index ["token_holder_id"], name: "index_quests_on_token_holder_id"
  end

  add_foreign_key "players", "players", column: "left_pointee_id"
  add_foreign_key "players", "players", column: "right_pointee_id"
  add_foreign_key "quests", "players", column: "leader_id"
  add_foreign_key "quests", "players", column: "token_holder_id"
end
