FactoryBot.define do
  factory :radio_station do
    category factory: :category

    name              { Faker::Company.name }
    description       { Faker::Lorem.paragraph }
    short_description { Faker::Lorem.sentence }
    location          { Faker::Address.country }
    website           { Faker::Internet.url }
    stream_url        { Faker::Internet.url }

    image            { fixture_file_upload(Rails.root.join('spec', 'support', 'attachments', 'logo1.png'), 'image/png') }
    wallpaper        { fixture_file_upload(Rails.root.join('spec', 'support', 'attachments', 'wallpaper.png'), 'image/png') }
  end
end
