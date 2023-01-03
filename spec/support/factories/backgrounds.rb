FactoryBot.define do
  factory :background do
    location                 { 0 }
    line_1                   { Faker::Lorem.sentence }
    background_slider_body   { Faker::Lorem.sentence }
    background_slider_header { Faker::Lorem.sentence }
    title                    { Faker::Lorem.sentence }
    description              { Faker::Lorem.sentence }
    section_1                { 'LoggedOutPreheader' }
    logged_in_header         { 'LoggedInPreheader' }
  end
end
