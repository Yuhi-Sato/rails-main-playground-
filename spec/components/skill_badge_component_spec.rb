require "rails_helper"

RSpec.describe SkillBadgeComponent, type: :component do
  it "shows the category-colored pill and the right number of dots for the level" do
    skill = build_stubbed(:skill, name: "Ruby", category: "language", level: 4)

    render_inline(described_class.new(skill: skill))

    expect(page).to have_text("Language")
    expect(page).to have_text("Ruby")
    expect(page).to have_css("span.bg-indigo-500", count: 4)
    expect(page).to have_css("span.bg-slate-200", count: 1)
  end
end
