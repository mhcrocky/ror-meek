FactoryBot.define do
  factory :post do
    release_date      { Faker::Date.between(3.years.ago, Date.today) }
    body              { 'body' }
    short_description { 'short description'}
  end
end
