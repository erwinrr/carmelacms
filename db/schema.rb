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

ActiveRecord::Schema.define(version: 2019_01_30_205959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "basic_forms", force: :cascade do |t|
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "category"
    t.index ["user_id"], name: "index_basic_forms_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "title"
    t.string "vin_number"
    t.string "stock_number"
    t.integer "msrp_price"
    t.integer "finance_payment"
    t.integer "lease_payment"
    t.string "engine"
    t.string "transmission"
    t.string "drivetrain"
    t.string "exterior"
    t.string "interior"
    t.integer "hwy_mpg"
    t.integer "city_mpg"
    t.boolean "was_scraped"
    t.string "scraped_url"
    t.string "carinfo_url"
    t.boolean "is_new"
    t.boolean "is_used"
    t.string "modelcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "main_image"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_cars_on_group_id"
  end

  create_table "customer_profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "endpoint"
    t.string "device_token"
    t.string "device_type"
    t.index ["user_id"], name: "index_customer_profiles_on_user_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_departments_on_group_id"
  end

  create_table "departments_users", id: false, force: :cascade do |t|
    t.bigint "department_id", null: false
    t.bigint "user_id", null: false
    t.index ["department_id"], name: "index_departments_users_on_department_id"
    t.index ["user_id"], name: "index_departments_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.string "scrape_url"
    t.string "topic_arn"
    t.index ["organization_id"], name: "index_groups_on_organization_id"
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id"
    t.index ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id"
  end

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "car_id"
    t.bigint "user_id"
    t.index ["car_id"], name: "index_likes_on_car_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "country_code"
    t.string "country_name"
    t.string "county"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "state"
    t.string "street"
    t.string "street_number"
    t.string "town"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "topic_arn"
  end

  create_table "page_impressions", force: :cascade do |t|
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "page_id"
    t.index ["page_id"], name: "index_page_impressions_on_page_id"
    t.index ["user_id"], name: "index_page_impressions_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "total_views"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_pages_on_organization_id"
  end

  create_table "push_notification_posts", force: :cascade do |t|
    t.boolean "is_published"
    t.string "aws_message_id"
    t.string "aws_error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "push_notification_id"
    t.index ["push_notification_id"], name: "index_push_notification_posts_on_push_notification_id"
    t.index ["user_id"], name: "index_push_notification_posts_on_user_id"
  end

  create_table "push_notifications", force: :cascade do |t|
    t.string "title"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.integer "sender_id"
    t.string "notification_type"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_push_notifications_on_group_id"
    t.index ["organization_id"], name: "index_push_notifications_on_organization_id"
  end

  create_table "push_notifications_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "push_notification_id", null: false
    t.string "aws_message_id"
    t.string "aws_error"
    t.boolean "published"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "session_token"
    t.text "settings"
    t.string "title"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.bigint "customer_profile_id"
    t.index ["customer_profile_id"], name: "index_users_on_customer_profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "basic_forms", "users"
  add_foreign_key "cars", "groups"
  add_foreign_key "customer_profiles", "users"
  add_foreign_key "departments", "groups"
  add_foreign_key "groups", "organizations"
  add_foreign_key "likes", "cars"
  add_foreign_key "likes", "users"
  add_foreign_key "locations", "users"
  add_foreign_key "page_impressions", "pages"
  add_foreign_key "page_impressions", "users"
  add_foreign_key "pages", "organizations"
  add_foreign_key "push_notification_posts", "push_notifications"
  add_foreign_key "push_notification_posts", "users"
  add_foreign_key "push_notifications", "groups"
  add_foreign_key "push_notifications", "organizations"
  add_foreign_key "users", "customer_profiles"
end
