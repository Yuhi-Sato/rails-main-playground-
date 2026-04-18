FactoryBot.define do
  factory :contact, class: "Contact" do
    name    { Faker::Name.name }
    email   { Faker::Internet.email }
    message { Faker::Lorem.paragraph(sentence_count: 5) }

    initialize_with { new(attributes) }
    skip_create
  end
end
