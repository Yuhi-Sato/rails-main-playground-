require "rails_helper"

RSpec.describe "Projects", type: :request do
  it "lists kept projects" do
    kept     = create(:project, title: "Listed")
    create(:project, :discarded, title: "Gone")

    get "/projects"

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(kept.title)
    expect(response.body).not_to include("Gone")
  end

  it "shows a project by id" do
    project = create(:project, title: "Shown")
    get "/projects/#{project.id}"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Shown")
  end
end
