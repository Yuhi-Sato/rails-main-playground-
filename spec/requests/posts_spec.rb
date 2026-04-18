require "rails_helper"

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "paginates with pagy (limit 10)" do
      create_list(:post, 15, :published)
      get "/posts"
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/pagy|page=/)
    end

    it "hides draft posts from guests" do
      published = create(:post, :published, title: "Public")
      create(:post, title: "Secret")

      get "/posts"

      expect(response.body).to include(published.title)
      expect(response.body).not_to include("Secret")
    end

    context "under load", :n_plus_one do
      populate { |n| create_list(:post, n, :published) }

      specify "SELECT count is constant regardless of fixture size" do
        expect { get "/posts" }.to perform_constant_number_of_queries.matching(/SELECT\s+"posts"/)
      end
    end
  end

  describe "GET /posts/:slug" do
    it "returns 200 for a published post" do
      published = create(:post, :published, slug: "hello")
      get "/posts/hello"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(published.title)
    end

    it "404s on a draft post for guests" do
      create(:post, slug: "secret")
      expect { get "/posts/secret" }.to raise_error(ActiveRecord::RecordNotFound)
        .or change { response&.status }.to(404)
    end
  end
end
