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

ActiveRecord::Schema[7.1].define(version: 2024_05_13_125535) do
  create_table "buffet_payment_methods", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.integer "payment_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_buffet_payment_methods_on_buffet_id"
    t.index ["payment_method_id"], name: "index_buffet_payment_methods_on_payment_method_id"
  end

  create_table "buffets", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "registration_code"
    t.string "phone_number"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "description"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_buffets_on_owner_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "personal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "min_guests"
    t.integer "max_guests"
    t.integer "duration"
    t.text "menu_details"
    t.boolean "alcohol_option"
    t.boolean "decoration_option"
    t.boolean "parking_service_option"
    t.boolean "location_option"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "base_price", precision: 8, scale: 2
    t.decimal "extra_guest", precision: 8, scale: 2
    t.decimal "extra_hour", precision: 8, scale: 2
    t.decimal "we_base_price", precision: 8, scale: 2
    t.decimal "we_extra_guest", precision: 8, scale: 2
    t.decimal "we_extra_hour", precision: 8, scale: 2
    t.index ["buffet_id"], name: "index_event_types_on_buffet_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "buffet_id", null: false
    t.integer "event_type_id", null: false
    t.date "event_date"
    t.integer "estimated_guests"
    t.text "event_details"
    t.string "code"
    t.string "event_address"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "final_price"
    t.date "price_valid_until"
    t.decimal "extra_fee"
    t.decimal "discount"
    t.text "adjustment_description"
    t.integer "payment_method_id"
    t.index ["buffet_id"], name: "index_orders_on_buffet_id"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["event_type_id"], name: "index_orders_on_event_type_id"
    t.index ["payment_method_id"], name: "index_orders_on_payment_method_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "buffet_payment_methods", "buffets"
  add_foreign_key "buffet_payment_methods", "payment_methods"
  add_foreign_key "buffets", "owners"
  add_foreign_key "event_types", "buffets"
  add_foreign_key "orders", "buffets"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "event_types"
  add_foreign_key "orders", "payment_methods"
end
