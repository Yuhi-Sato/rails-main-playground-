require "rails_helper"

RSpec.describe PostResource do
  it "serializes a single post to JSON with the given host param" do
    post = create(:post, :published, slug: "alba-rocks", title: "Alba rocks")

    json = described_class.new(post, params: { host: "https://yuhi.dev" }).serialize
    payload = JSON.parse(json)

    expect(payload).to include(
      "slug"  => "alba-rocks",
      "title" => "Alba rocks",
      "status" => "published",
      "url"   => "https://yuhi.dev/posts/alba-rocks"
    )
    expect(payload["published_at"]).to match(/\A\d{4}-\d{2}-\d{2}T/)
  end

  it "serializes a collection" do
    create_list(:post, 3, :published)
    payload = JSON.parse(described_class.new(Post.all).serialize)
    expect(payload.size).to eq(3)
  end
end
