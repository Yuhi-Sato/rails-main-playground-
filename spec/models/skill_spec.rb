require "rails_helper"

RSpec.describe Skill, type: :model do
  it "requires name and category, and validates level range" do
    expect(Skill.new).not_to be_valid
    expect(build(:skill, level: 0)).not_to be_valid
    expect(build(:skill, level: 6)).not_to be_valid
    expect(build(:skill, level: 3)).to be_valid
  end

  it "accepts only whitelisted categories" do
    expect(build(:skill, category: "not-a-thing")).not_to be_valid
    Skill::CATEGORIES.each do |cat|
      expect(build(:skill, category: cat)).to be_valid
    end
  end
end
