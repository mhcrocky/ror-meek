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

ActiveRecord::Schema[7.0].define(version: 2022_04_29_073724) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.integer "author_id"
    t.string "author_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.integer "region_id"
    t.string "postcode"
    t.integer "country_id", default: 235
    t.string "telephone"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.index ["country_id"], name: "index_addresses_on_country_id"
    t.index ["region_id"], name: "index_addresses_on_region_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.integer "category_id"
    t.string "slug"
    t.text "description", default: "", null: false
    t.text "short_description", default: "", null: false
    t.string "website"
    t.string "feed_url"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "meta_title"
    t.string "h1"
    t.boolean "noindex", default: true, null: false
    t.text "meta_description"
    t.boolean "feed_is_broken", default: false, null: false
    t.string "wallpaper_file_name"
    t.string "wallpaper_content_type"
    t.integer "wallpaper_file_size"
    t.datetime "wallpaper_updated_at", precision: nil
    t.boolean "autopublish_new", default: false, null: false
    t.boolean "autopublish_old", default: false, null: false
    t.text "schema"
    t.string "tags", default: "", null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer "user_id"
    t.string "action"
    t.string "ip"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["user_id"], name: "index_audits_on_user_id"
  end

  create_table "backgrounds", force: :cascade do |t|
    t.integer "location"
    t.text "line_1"
    t.text "background_slider_body"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "title"
    t.text "description"
    t.string "background_slider_file_name"
    t.string "background_slider_content_type"
    t.integer "background_slider_file_size"
    t.datetime "background_slider_updated_at", precision: nil
    t.text "background_slider_header"
    t.text "section_1", default: "<div> </div>"
    t.text "section_2", default: "<div> </div>"
    t.text "section_3", default: "<div> </div>"
    t.text "section_4", default: "<div> </div>"
    t.text "logged_in_header", default: "<div> </div>"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "kind"
    t.string "slug"
    t.string "meta_title"
    t.string "h1"
    t.text "meta_description", default: "", null: false
    t.string "wallpaper_file_name"
    t.string "wallpaper_content_type"
    t.integer "wallpaper_file_size"
    t.datetime "wallpaper_updated_at", precision: nil
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "church_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "countries", force: :cascade do |t|
    t.string "iso2_code"
    t.string "iso3_code"
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "podcast_id"
    t.string "name"
    t.text "stream_url"
    t.integer "duration"
    t.date "release_date"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "slug"
    t.string "meta_title"
    t.string "h1"
    t.boolean "noindex", default: false, null: false
    t.boolean "video", default: false, null: false
    t.text "short_description", default: "", null: false
    t.boolean "already_shared", default: false
    t.text "schema"
    t.text "transcription", default: ""
    t.string "tags", default: ""
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
    t.index ["slug"], name: "index_episodes_on_slug"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "favoritable_id"
    t.string "favoritable_type"
    t.integer "user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "body"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "footers", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "position"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type"
    t.string "scope"
    t.datetime "created_at", precision: nil
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "identities", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "email"
    t.string "name"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "sender_id"
    t.string "recipient_email", null: false
    t.string "token"
    t.string "subject", null: false
    t.text "message", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "friend_name", null: false
  end

  create_table "landing_pages", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "content"
    t.string "slug"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["slug"], name: "index_landing_pages_on_slug", unique: true
  end

  create_table "plays", force: :cascade do |t|
    t.integer "user_id"
    t.integer "media_id"
    t.string "media_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "stopped_at", default: 0, null: false
    t.index ["media_id", "media_type"], name: "index_plays_on_media_id_and_media_type"
    t.index ["user_id"], name: "index_plays_on_user_id"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string "name"
    t.integer "category_id"
    t.string "slug"
    t.text "description"
    t.text "short_description"
    t.string "website"
    t.string "feed_url"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "meta_title"
    t.string "h1"
    t.boolean "noindex", default: true, null: false
    t.text "meta_description"
    t.boolean "feed_is_broken", default: false, null: false
    t.string "wallpaper_file_name"
    t.string "wallpaper_content_type"
    t.integer "wallpaper_file_size"
    t.datetime "wallpaper_updated_at", precision: nil
    t.string "secondary_feed_url"
    t.string "video_youtube_feed"
    t.string "video_vimeo_feed"
    t.string "video_rss_feed"
    t.boolean "autopublish_new", default: false, null: false
    t.boolean "autopublish_old", default: false, null: false
    t.integer "distance_in_days"
    t.text "schema"
    t.boolean "create_transcription", default: false
    t.boolean "transcript_only_new", default: false
    t.string "tags"
    t.boolean "private", default: false, null: false
    t.index ["category_id"], name: "index_podcasts_on_category_id"
    t.index ["slug"], name: "index_podcasts_on_slug", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.integer "article_id"
    t.string "name"
    t.text "body", default: "", null: false
    t.string "stream_url"
    t.date "release_date"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "slug"
    t.string "meta_title"
    t.string "h1"
    t.boolean "noindex", default: false, null: false
    t.text "short_description", default: "", null: false
    t.boolean "already_shared", default: false
    t.text "schema"
    t.string "tags", default: "", null: false
  end

  create_table "radio_stations", force: :cascade do |t|
    t.string "name"
    t.integer "category_id"
    t.text "description"
    t.text "short_description"
    t.string "location"
    t.string "website"
    t.text "stream_url"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "slug"
    t.string "meta_title"
    t.string "h1"
    t.boolean "noindex", default: true, null: false
    t.text "meta_description"
    t.string "wallpaper_file_name"
    t.string "wallpaper_content_type"
    t.integer "wallpaper_file_size"
    t.datetime "wallpaper_updated_at", precision: nil
    t.index ["category_id"], name: "index_radio_stations_on_category_id"
    t.index ["slug"], name: "index_radio_stations_on_slug", unique: true
  end

  create_table "regions", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "country_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "share_queues", force: :cascade do |t|
    t.integer "episode_id"
    t.datetime "published_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "publish_type", default: 0, null: false
    t.string "episode_name"
    t.date "episode_release_date"
  end

  create_table "share_schedules", force: :cascade do |t|
    t.integer "hours", default: 0, null: false
    t.integer "minutes", default: 0, null: false
  end

  create_table "static_pages", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "content"
    t.integer "subject"
    t.string "slug"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "stylesheets", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "first_name"
    t.string "last_name"
    t.string "church_name", default: "", null: false
    t.integer "church_type_id"
    t.integer "radio_station_id"
    t.boolean "is_auto_play", default: true
    t.string "profile_pic_file_name"
    t.string "profile_pic_content_type"
    t.integer "profile_pic_file_size"
    t.datetime "profile_pic_updated_at", precision: nil
    t.string "background_pic_file_name"
    t.string "background_pic_content_type"
    t.integer "background_pic_file_size"
    t.datetime "background_pic_updated_at", precision: nil
    t.string "background_color", default: "#0199e2"
    t.string "slug"
    t.string "username"
    t.string "facebook", default: "", null: false
    t.string "twitter", default: "", null: false
    t.string "linkedin", default: "", null: false
    t.decimal "christian_for", precision: 8, scale: 2
    t.text "verse", default: "", null: false
    t.string "gender", default: "", null: false
    t.string "language", default: "", null: false
    t.integer "invitation_id"
    t.date "birth_date"
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.boolean "weekly_emails_subscriptions", default: true, null: false
    t.integer "activecampaign_id"
    t.index ["church_type_id"], name: "index_users_on_church_type_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["radio_station_id"], name: "index_users_on_radio_station_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
