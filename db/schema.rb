# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140331101930) do

  create_table "albums", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bases", force: true do |t|
    t.string   "title",      null: false
    t.text     "detail",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkouts", force: true do |t|
    t.integer  "checkout_id"
    t.integer  "preapproval_id"
    t.integer  "account_id"
    t.string   "state"
    t.string   "short_description"
    t.text     "long_description"
    t.string   "currency"
    t.decimal  "amount"
    t.decimal  "app_fee"
    t.string   "fee_payer"
    t.decimal  "gross"
    t.decimal  "fee"
    t.string   "reference_id"
    t.text     "redirect_uri"
    t.text     "callback_uri"
    t.text     "checkout_uri"
    t.text     "preapproval_uri"
    t.string   "payer_email"
    t.string   "payer_name"
    t.text     "cancel_reason"
    t.text     "refund_reason"
    t.boolean  "auto_capture"
    t.boolean  "require_shipping"
    t.text     "shipping_address"
    t.decimal  "tax"
    t.string   "security_token"
    t.string   "access_token"
    t.string   "model"
    t.string   "period"
    t.integer  "frequency"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "manage_uri"
    t.boolean  "auto_recur"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkouts", ["checkout_id"], name: "index_checkouts_on_checkout_id"

  create_table "colors", force: true do |t|
    t.string   "name"
    t.string   "rgb"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors_product_templates", force: true do |t|
    t.integer "color_id"
    t.integer "product_template_id"
  end

  create_table "credit_cards", force: true do |t|
    t.string   "card_no"
    t.string   "card_provider"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_cards", ["user_id"], name: "index_credit_cards_on_user_id"

  create_table "events", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "quantity",   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "color_id"
    t.integer  "size_id"
  end

  create_table "occupations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "order_items", force: true do |t|
    t.string   "price"
    t.string   "size"
    t.integer  "count"
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  add_index "order_items", ["order_id", "product_id"], name: "index_order_items_on_order_id_and_product_id"

  create_table "orders", force: true do |t|
    t.string   "sum"
    t.datetime "created_at"
    t.integer  "user_id"
    t.datetime "updated_at"
    t.integer  "state_id"
    t.string   "order_number", default: "1395933961", null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "pictures", force: true do |t|
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "pictures", ["album_id"], name: "index_pictures_on_album_id"

  create_table "product_images", force: true do |t|
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_image_file_name"
    t.string   "product_image_content_type"
    t.integer  "product_image_file_size"
    t.datetime "product_image_updated_at"
  end

  create_table "product_templates", force: true do |t|
    t.string   "template_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "template_category_id"
    t.string   "back_image_file_name"
    t.string   "back_image_content_type"
    t.integer  "back_image_file_size"
    t.datetime "back_image_updated_at"
    t.string   "side_image_file_name"
    t.string   "side_image_content_type"
    t.integer  "side_image_file_size"
    t.datetime "side_image_updated_at"
    t.string   "back_image_mask_file_name"
    t.string   "back_image_mask_content_type"
    t.integer  "back_image_mask_file_size"
    t.datetime "back_image_mask_updated_at"
    t.string   "side_image_mask_file_name"
    t.string   "side_image_mask_content_type"
    t.integer  "side_image_mask_file_size"
    t.datetime "side_image_mask_updated_at"
    t.decimal  "price"
    t.string   "head_image_file_name"
    t.string   "head_image_content_type"
    t.integer  "head_image_file_size"
    t.datetime "head_image_updated_at"
    t.string   "head_image_mask_file_name"
    t.string   "head_image_mask_content_type"
    t.integer  "head_image_mask_file_size"
    t.datetime "head_image_mask_updated_at"
  end

  add_index "product_templates", ["template_category_id"], name: "index_product_templates_on_template_category_id"

  create_table "product_templates_sizes", force: true do |t|
    t.integer "size_id"
    t.integer "product_template_id"
  end

  create_table "products", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.integer  "degree"
    t.decimal  "price"
    t.integer  "product_template_id"
    t.integer  "publish_id"
    t.integer  "position_X"
    t.integer  "position_Y"
    t.integer  "size_W"
    t.integer  "size_H"
    t.decimal  "base_price"
    t.integer  "state_id"
  end

  add_index "products", ["product_template_id", "publish_id"], name: "index_products_on_product_template_id_and_publish_id"

  create_table "publish_categories", force: true do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishes", force: true do |t|
    t.string   "name",                       null: false
    t.text     "description",                null: false
    t.integer  "user_id",                    null: false
    t.integer  "state_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "publish_image_file_name"
    t.string   "publish_image_content_type"
    t.integer  "publish_image_file_size"
    t.datetime "publish_image_updated_at"
    t.integer  "publish_category_id"
  end

  add_index "publishes", ["publish_category_id"], name: "index_publishes_on_publish_category_id"
  add_index "publishes", ["user_id"], name: "index_publishes_on_user_id"

  create_table "publishes_tags", force: true do |t|
    t.integer  "publish_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "sizes", force: true do |t|
    t.string   "name"
    t.string   "size_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "tags", force: true do |t|
    t.string   "tag_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "color_id"
  end

  create_table "tags_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name",                                null: false
    t.string   "sex",                                 null: false
    t.text     "description"
    t.text     "motto"
    t.string   "phone"
    t.text     "address"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "occupation_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
