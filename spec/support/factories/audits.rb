FactoryBot.define do
  factory :audit do
    user { nil }
    action { "MyString" }
    ip { "MyString" }
  end

end
