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

ActiveRecord::Schema.define(version: 2021_01_07_110723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transactions", force: :cascade do |t|
    t.bigint "apn_code"
    t.decimal "rrp"
    t.decimal "last_buy_price"
    t.string "item_desc"
    t.string "author"
    t.string "product_category"
    t.integer "actual_stock"
    t.date "trans_date"
    t.time "trans_time"
    t.string "trans_document"
    t.string "trans_ref"
    t.integer "trans_qty"
    t.decimal "trans_total_ex_tax"
    t.decimal "trans_total_tax"
    t.decimal "trans_discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
