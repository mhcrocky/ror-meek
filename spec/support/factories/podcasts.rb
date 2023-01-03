FactoryBot.define do
  factory :podcast do
    category factory: :category

    name              { Faker::Company.name }
    description       { Faker::Lorem.paragraph }
    short_description { Faker::Lorem.sentence }
    website           { Faker::Internet.url }
    feed_url          { Faker::Internet.url }
    meta_title        { Faker::Lorem.sentence }

    autopublish_old  { false }
    autopublish_new  { false }

    image            { fixture_file_upload(Rails.root.join('spec', 'support', 'attachments', 'logo1.png'), 'image/png') }
    wallpaper        { fixture_file_upload(Rails.root.join('spec', 'support', 'attachments', 'wallpaper.png'), 'image/png') }
  end
end
