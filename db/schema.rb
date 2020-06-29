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

ActiveRecord::Schema.define(version: 2020_06_29_065506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stays", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "tenant_id", null: false
    t.bigint "studio_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["studio_id"], name: "index_stays_on_studio_id"
    t.index ["tenant_id"], name: "index_stays_on_tenant_id"
  end

  create_table "studios", force: :cascade do |t|
    t.string "name"
    t.integer "monthly_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tenants", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "stays", "studios"
  add_foreign_key "stays", "tenants"
end
