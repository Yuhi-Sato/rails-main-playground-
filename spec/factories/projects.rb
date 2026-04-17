FactoryBot.define do
  factory :project do
    title { "MyString" }
    description { "MyText" }
    tech_stack { "MyString" }
    url { "MyString" }
    github_url { "MyString" }
    featured { false }
    position { 1 }
  end
end
