FactoryBot.define do
  # NOTE: This factory is "private", do not try to use it directly
  factory :user do
    sequence(:email)  { |n| "email#{n}@gmailinator.com" }
    password          { 'password' }
    first_name        { Faker::Name.name }
    last_name         { Faker::Name.name }
    radio_station_id  { nil }
    is_auto_play      { false }

    after(:create) do |user, evaluator|
      FactoryBot.create(:address, user: user)
    end
  end

  factory :confirmed_user, parent: :user do
    after(:create) { |user| user.confirm }
  end

  factory :unconfirmed_user, parent: :user do
  end
end
