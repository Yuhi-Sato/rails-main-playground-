FactoryBot.define do
  factory :skill do
    sequence(:name) { |n| "Skill #{n}" }
    category { Skill::CATEGORIES.sample }
    level    { 3 }
    sequence(:position) { |n| n }
  end
end
