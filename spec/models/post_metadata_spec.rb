require "rails_helper"

RSpec.describe Post, "store_attribute-backed metadata" do
  it "types reading_time as integer and defaults to 5" do
    post = Post.new(title: "X")
    expect(post.reading_time).to eq(5)

    post.reading_time = "12"
    expect(post.reading_time).to eq(12)
  end

  it "round-trips canonical_url through JSONB" do
    post = create(:post, canonical_url: "https://example.com/p/1")
    expect(post.reload.canonical_url).to eq("https://example.com/p/1")
    expect(post.reload.metadata["canonical_url"]).to eq("https://example.com/p/1")
  end

  it "refuses non-integer reading_time via validation" do
    post = build(:post, reading_time: 0)
    expect(post).not_to be_valid
  end
end
