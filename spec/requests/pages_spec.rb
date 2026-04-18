require "rails_helper"

RSpec.describe "Pages", type: :request do
  it "renders home with featured projects and recent posts" do
    create(:project, :featured, title: "Show me")
    create(:post, :published, title: "Hello")

    get "/"

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Show me")
    expect(response.body).to include("Hello")
  end

  it "renders about" do
    create(:skill, name: "Ruby", category: "language")
    get "/about"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Ruby")
  end

  it "renders stats with the fx-backed count" do
    create_list(:post, 2, :published)
    get "/stats"
    expect(response).to have_http_status(:ok)
    expect(response.body).to match(/Published posts.*\b2\b/m)
  end
end
