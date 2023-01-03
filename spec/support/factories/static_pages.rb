FactoryBot.define do

  factory :static_page do
    name    { Faker::Lorem.word }
    title   { Faker::Lorem.words(2) }
    content { Faker::Lorem.paragraphs(3) }
    subject { rand(3) }
  end

end
