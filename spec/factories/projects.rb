FactoryBot.define do
  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
    tech_stack  { "Rails, PostgreSQL, Hotwire" }
    url         { Faker::Internet.url }
    github_url  { "https://github.com/yuhi/example" }
    featured    { false }
    sequence(:position) { |n| n }

    trait :featured do
      featured { true }
    end

    trait :discarded do
      discarded_at { Time.current }
    end
  end
end
