require "rails_helper"

RSpec.describe Project, type: :model do
  it "requires a title" do
    expect(Project.new).not_to be_valid
    expect(Project.new(title: "x")).to be_valid
  end

  it "parses the tech_stack into a list" do
    project = build(:project, tech_stack: "Ruby, Rails , PostgreSQL")
    expect(project.tech_list).to eq(%w[Ruby Rails PostgreSQL])
  end

  it "scopes featured_first to kept records in featured, position order" do
    featured    = create(:project, :featured, position: 2)
    plain       = create(:project, position: 1)
    _discarded  = create(:project, :featured, :discarded, position: 0)

    expect(Project.featured_first.to_a).to eq([featured, plain])
  end
end
