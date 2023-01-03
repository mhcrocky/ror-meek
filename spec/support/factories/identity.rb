FactoryBot.define do

  factory :identity do
    user       { nil }
    name       { Faker::Name.name }
    provider   { 'facebook' }
    uid        { Faker::Number.number(15) }
    sequence(:email)  { |n| "email#{n}@gmailinator.com" }
  end

end
