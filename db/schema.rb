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

ActiveRecord::Schema[8.0].define(version: 2025_08_11_060619) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "api_clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "api_key", null: false
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_api_clients_on_api_key", unique: true
    t.index ["name"], name: "index_api_clients_on_name", unique: true
    t.index ["revoked_at"], name: "index_api_clients_on_revoked_at"
  end

  create_table "point_ledgers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "purchase_id", null: false
    t.integer "points", null: false
    t.string "reason", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_point_ledgers_on_purchase_id"
    t.index ["user_id"], name: "index_point_ledgers_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "amount_cents", null: false
    t.string "currency", default: "USD", null: false
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "reward_type"
    t.string "reason"
    t.datetime "awarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reward_type"], name: "index_rewards_on_reward_type"
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.date "birth_date"
    t.string "country"
    t.datetime "first_purchase_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "point_ledgers", "purchases"
  add_foreign_key "point_ledgers", "users"
  add_foreign_key "purchases", "users"
  add_foreign_key "rewards", "users"
end
