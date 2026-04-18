FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}: #{Faker::Lorem.sentence(word_count: 4)}" }
    sequence(:slug)  { |n| "post-#{n}-#{SecureRandom.hex(3)}" }
    body { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    tags { Faker::Lorem.words(number: 3) }
    status { "draft" }

    trait :published do
      status { "published" }
      published_at { 1.day.ago }
    end

    trait :archived do
      status { "archived" }
      published_at { 1.week.ago }
    end

    trait :scheduled do
      status { "draft" }
      published_at { 1.week.from_now }
    end

    trait :discarded do
      discarded_at { Time.current }
    end
  end
end
