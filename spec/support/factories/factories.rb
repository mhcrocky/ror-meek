FactoryBot.define do
  factory :share_queue do
    published_at { nil }
    publish_type { ShareQueue.publish_types.keys.sample }

    association :episode, factory: :episode
  end

  factory :share_schedule do
    hours   { DateTime.now.hour }
    minutes { DateTime.now.min }
  end
end
