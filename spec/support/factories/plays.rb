FactoryBot.define do

  factory :play do
    user_id { nil }
    stopped_at { 0 }

    association :media
  end

end
