require "rails_helper"

RSpec.describe Post, type: :model do
  describe "validations" do
    it "requires title and generates a slug when absent" do
      post = Post.new(title: "Hello World")
      expect(post).to be_valid
      expect(post.slug).to eq("hello-world")
    end

    it "falls back to a nanoid when the title cannot produce a slug" do
      post = Post.new(title: "???")
      expect(post).to be_valid
      expect(post.slug).to match(/\A[0-9A-Za-z_-]{10}\z/)
    end

    it "rejects duplicate slugs" do
      create(:post, slug: "dup")
      post = build(:post, slug: "dup")
      expect(post).not_to be_valid
    end
  end

  describe "state machine" do
    it "starts as a draft" do
      expect(build(:post).status).to eq("draft")
    end

    it "transitions draft → published and backfills published_at" do
      post = create(:post, published_at: nil)
      freeze_time do
        expect { post.publish! }.to change(post, :status).from("draft").to("published")
        expect(post.reload.published_at).to be_within(1.second).of(Time.current)
      end
    end

    it "supports publish → archived → publish → unpublish" do
      post = create(:post, :published)
      expect { post.archive! }.to change(post, :status).to("archived")
      expect { post.publish! }.to change(post, :status).to("published")
      expect { post.unpublish! }.to change(post, :status).to("draft")
    end
  end

  describe "scopes" do
    it "includes only published, kept, and non-scheduled posts" do
      published = create(:post, :published)
      create(:post)
      create(:post, :published, :discarded)
      create(:post, :scheduled)

      expect(Post.published).to contain_exactly(published)
    end
  end

  describe ".published_count_via_fx" do
    it "returns the same count as the scope" do
      create_list(:post, 2, :published)
      create(:post)

      expect(Post.published_count_via_fx).to eq(Post.published.count)
    end
  end

  describe "logidze" do
    it "captures a history entry on create" do
      post = create(:post, :published)
      expect(post.reload.log_data).to be_present
      expect(post.log_version).to be >= 1
    end
  end
end
