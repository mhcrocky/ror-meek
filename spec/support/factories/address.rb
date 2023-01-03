FactoryBot.define do

  factory :address do
    first_name { "MyString" }
    last_name { "MyString" }
    address_1 { "MyString" }
    address_2 { "MyString" }
    city { "MyString" }
    region { nil }
    postcode { "MyString" }
    country { nil }
    telephone { "MyString" }
  end

end
