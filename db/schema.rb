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

ActiveRecord::Schema.define(version: 20140315041032) do

  create_table "albums", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "illustrations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.integer  "user_id"
    t.datetime "updated_at"
    t.string   "ill_image_file_name"
    t.string   "ill_image_content_type"
    t.integer  "ill_image_file_size"
    t.datetime "ill_image_updated_at"
  end

  add_index "illustrations", ["user_id"], name: "index_illustrations_on_user_id"

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
  end

  add_index "order_items", ["order_id", "product_id"], name: "index_order_items_on_order_id_and_product_id"

  create_table "orders", force: true do |t|
    t.string   "sum"
    t.datetime "created_at"
    t.integer  "user_id"
    t.datetime "updated_at"
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

  create_table "product_templates", force: true do |t|
    t.string   "template_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "template_category_id"
    t.integer  "intial_X"
    t.integer  "intial_Y"
    t.integer  "size_W"
    t.integer  "size_H"
    t.string   "front_image_file_name"
    t.string   "front_image_content_type"
    t.integer  "front_image_file_size"
    t.datetime "front_image_updated_at"
    t.string   "back_image_file_name"
    t.string   "back_image_content_type"
    t.integer  "back_image_file_size"
    t.datetime "back_image_updated_at"
    t.string   "side_image_file_name"
    t.string   "side_image_content_type"
    t.integer  "side_image_file_size"
    t.datetime "side_image_updated_at"
    t.string   "front_image_mask_file_name"
    t.string   "front_image_mask_content_type"
    t.integer  "front_image_mask_file_size"
    t.datetime "front_image_mask_updated_at"
    t.string   "back_image_mask_file_name"
    t.string   "back_image_mask_content_type"
    t.integer  "back_image_mask_file_size"
    t.datetime "back_image_mask_updated_at"
    t.string   "side_image_mask_file_name"
    t.string   "side_image_mask_content_type"
    t.integer  "side_image_mask_file_size"
    t.datetime "side_image_mask_updated_at"
  end

  add_index "product_templates", ["template_category_id"], name: "index_product_templates_on_template_category_id"

  create_table "products", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.integer  "position_X"
    t.integer  "position_Y"
    t.integer  "degree"
    t.integer  "ill_size_W"
    t.integer  "ill_size_H"
    t.string   "product_image_file_name"
    t.string   "product_image_content_type"
    t.integer  "product_image_file_size"
    t.datetime "product_image_updated_at"
    t.integer  "price"
    t.integer  "product_template_id"
    t.integer  "illustration_id"
  end

  add_index "products", ["product_template_id", "illustration_id"], name: "index_products_on_product_template_id_and_illustration_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "tags", force: true do |t|
    t.string   "tag_name"
    t.text     "description"
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
