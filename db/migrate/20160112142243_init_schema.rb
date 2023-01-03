class InitSchema < ActiveRecord::Migration[7.0]
  def up

    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"

    create_table "active_admin_comments", force: true do |t|
      t.string   "namespace"
      t.text     "body"
      t.string   "resource_id",   null: false
      t.string   "resource_type", null: false
      t.integer  "author_id"
      t.string   "author_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

    create_table "addresses", force: true do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "address_1"
      t.string   "address_2"
      t.string   "city"
      t.integer  "region_id"
      t.string   "postcode"
      t.integer  "country_id", default: 235
      t.string   "telephone"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
    end

    add_index "addresses", ["country_id"], name: "index_addresses_on_country_id", using: :btree
    add_index "addresses", ["region_id"], name: "index_addresses_on_region_id", using: :btree

    create_table "admin_users", force: true do |t|
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
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

    create_table "attachments", force: true do |t|
      t.integer  "background_id"
      t.string   "file_file_name"
      t.string   "file_content_type"
      t.integer  "file_file_size"
      t.datetime "file_updated_at"
      t.string   "type"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
    end

    create_table "audits", force: true do |t|
      t.integer  "user_id"
      t.string   "action"
      t.string   "ip"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "audits", ["user_id"], name: "index_audits_on_user_id", using: :btree

    create_table "backgrounds", force: true do |t|
      t.integer  "location"
      t.text     "line_1"
      t.text     "line_2"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "title"
      t.text     "description"
    end

    create_table "categories", force: true do |t|
      t.integer  "parent_id"
      t.string   "name"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "kind"
      t.string   "slug"
      t.string   "meta_title"
      t.string   "h1"
      t.text     "meta_description", default: "", null: false
    end

    add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

    create_table "church_types", force: true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "countries", force: true do |t|
      t.string   "iso2_code"
      t.string   "iso3_code"
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "episodes", force: true do |t|
      t.integer  "podcast_id"
      t.string   "name"
      t.text     "stream_url"
      t.integer  "duration"
      t.datetime "release_date"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "slug"
      t.string   "meta_title"
      t.string   "h1"
      t.boolean  "noindex",      default: true, null: false
    end

    add_index "episodes", ["podcast_id"], name: "index_episodes_on_podcast_id", using: :btree
    add_index "episodes", ["slug"], name: "index_episodes_on_slug", using: :btree

    create_table "favorites", force: true do |t|
      t.integer  "favoritable_id"
      t.string   "favoritable_type"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

    create_table "feedbacks", force: true do |t|
      t.string   "name"
      t.string   "email"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "friendly_id_slugs", force: true do |t|
      t.string   "slug",           null: false
      t.integer  "sluggable_id",   null: false
      t.string   "sluggable_type"
      t.string   "scope"
      t.datetime "created_at"
    end

    add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

    create_table "identities", force: true do |t|
      t.integer  "user_id"
      t.string   "provider"
      t.string   "uid"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

    create_table "plays", force: true do |t|
      t.integer  "user_id"
      t.integer  "media_id"
      t.string   "media_type"
      t.boolean  "is_organic"
      t.integer  "duration"
      t.datetime "stopped_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "plays", ["media_id", "media_type"], name: "index_plays_on_media_id_and_media_type", using: :btree
    add_index "plays", ["user_id"], name: "index_plays_on_user_id", using: :btree

    create_table "podcasts", force: true do |t|
      t.string   "name"
      t.integer  "category_id"
      t.string   "slug"
      t.text     "description"
      t.text     "short_description"
      t.string   "website"
      t.string   "feed_url"
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.datetime "image_updated_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "meta_title"
      t.string   "h1"
      t.boolean  "noindex",            default: true,  null: false
      t.text     "meta_description"
      t.boolean  "feed_is_broken",     default: false, null: false
    end

    add_index "podcasts", ["category_id"], name: "index_podcasts_on_category_id", using: :btree
    add_index "podcasts", ["slug"], name: "index_podcasts_on_slug", unique: true, using: :btree

    create_table "radio_stations", force: true do |t|
      t.string   "name"
      t.integer  "category_id"
      t.text     "description"
      t.text     "short_description"
      t.string   "location"
      t.string   "website"
      t.text     "stream_url"
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.datetime "image_updated_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "slug"
      t.string   "meta_title"
      t.string   "h1"
      t.boolean  "noindex",            default: true, null: false
      t.text     "meta_description"
    end

    add_index "radio_stations", ["category_id"], name: "index_radio_stations_on_category_id", using: :btree
    add_index "radio_stations", ["slug"], name: "index_radio_stations_on_slug", unique: true, using: :btree

    create_table "regions", force: true do |t|
      t.string   "code"
      t.string   "name"
      t.integer  "country_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "static_pages", force: true do |t|
      t.string   "name"
      t.string   "title"
      t.text     "content"
      t.integer  "subject"
      t.string   "slug"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", force: true do |t|
      t.string   "email",                       default: "",        null: false
      t.string   "encrypted_password",          default: "",        null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",               default: 0,         null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "church_name"
      t.integer  "church_type_id"
      t.integer  "radio_station_id"
      t.boolean  "is_auto_play",                default: true
      t.string   "profile_pic_file_name"
      t.string   "profile_pic_content_type"
      t.integer  "profile_pic_file_size"
      t.datetime "profile_pic_updated_at"
      t.string   "background_pic_file_name"
      t.string   "background_pic_content_type"
      t.integer  "background_pic_file_size"
      t.datetime "background_pic_updated_at"
      t.string   "background_color",            default: "#0199e2"
      t.string   "slug"
      t.string   "username"
      t.string   "facebook"
      t.string   "twitter"
      t.string   "linkedin"
      t.integer  "christian_for"
      t.text     "verse"
      t.string   "birth_date"
      t.string   "gender"
      t.string   "language"
    end

    add_index "users", ["church_type_id"], name: "index_users_on_church_type_id", using: :btree
    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["radio_station_id"], name: "index_users_on_radio_station_id", using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

    create_table "votes", force: true do |t|
      t.integer "score",        null: false
      t.integer "user_id",      null: false
      t.integer "ratable_id",   null: false
      t.string  "ratable_type", null: false
    end

    add_index "votes", ["ratable_id", "ratable_type"], name: "index_votes_on_ratable_id_and_ratable_type", using: :btree

  end

  def down
    raise "Can not revert initial migration"
  end
end
