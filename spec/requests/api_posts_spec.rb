require "rails_helper"

RSpec.describe "Api::V1::Posts", type: :request do
  it "returns only published posts as JSON" do
    published = create(:post, :published, slug: "public-post", title: "Public")
    _draft    = create(:post, slug: "draft-post",  title: "Draft")

    get "/api/v1/posts"
    expect(response).to have_http_status(:ok)

    payload = JSON.parse(response.body)
    slugs   = payload.map { |p| p["slug"] }

    expect(slugs).to include(published.slug)
    expect(slugs).not_to include("draft-post")
  end

  it "supports full-text search via q=" do
    rails = create(:post, :published, title: "All about Rails", body: "Ruby on Rails")
    create(:post, :published, title: "Go routines", body: "concurrency")

    get "/api/v1/posts", params: { q: "rails" }

    payload = JSON.parse(response.body)
    expect(payload.map { |p| p["slug"] }).to eq([rails.slug])
  end
end
