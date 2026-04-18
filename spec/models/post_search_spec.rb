require "rails_helper"

RSpec.describe Post, ".search_text (pg_search)" do
  it "matches posts by title and body" do
    rails = create(:post, :published, title: "All about Rails", body: "Ruby on Rails")
    other = create(:post, :published, title: "Go routines", body: "concurrency")

    expect(Post.search_text("rails").to_a).to include(rails)
    expect(Post.search_text("rails").to_a).not_to include(other)
  end

  it "supports prefix search" do
    hotw = create(:post, :published, title: "Hotwire is great", body: "Turbo Frames")
    create(:post, :published, title: "Something else")

    expect(Post.search_text("hotw").to_a).to include(hotw)
  end
end
