require "rails_helper"

RSpec.describe ProjectCardComponent, type: :component do
  it "renders title, featured badge, tech chips, and links" do
    project = build_stubbed(
      :project,
      title: "Demo",
      featured: true,
      url: "https://example.com",
      github_url: "https://github.com/example/demo",
      tech_stack: "Ruby, Rails"
    )

    render_inline(described_class.new(project: project))

    expect(page).to have_text("Demo")
    expect(page).to have_text("Featured")
    expect(page).to have_text("Ruby")
    expect(page).to have_text("Rails")
    expect(page).to have_link("Visit →", href: "https://example.com")
    expect(page).to have_link("GitHub", href: "https://github.com/example/demo")
  end
end
