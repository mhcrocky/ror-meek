FactoryBot.define do
  factory :category do
    kind { rand(0..1) }
    name { Faker::Lorem.word }
    meta_description { 'meta description' }
  end
end
