FactoryBot.define do
  factory :article do
    category factory: :category
    description       { Faker::Lorem.paragraph }
    short_description { Faker::Lorem.sentence }
    website           { Faker::Internet.url }
    feed_url          { Faker::Internet.url }
    meta_title        { Faker::Lorem.sentence }
    wallpaper_content_type { "image/png" }
  end
end
