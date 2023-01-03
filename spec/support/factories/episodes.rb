FactoryBot.define do
  factory :episode do
    duration          { 60*2 }
    release_date      { Faker::Date.between(3.years.ago, Date.today) }
    name              { Faker::Company.name }
    meta_title        { Faker::Lorem.sentence }
    stream_url        { Faker::Internet.url }

    podcast_id        { nil }
    already_shared    { false }
  end
end
