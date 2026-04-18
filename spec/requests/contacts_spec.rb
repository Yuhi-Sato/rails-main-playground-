require "rails_helper"

RSpec.describe "Contacts", type: :request do
  describe "POST /contact" do
    it "redirects to thanks when valid and triggers the delivery" do
      params = { contact: { name: "Alice", email: "a@example.com", message: "Hi there — this is long enough." } }

      expect {
        post "/contact", params: params
      }.not_to raise_error

      expect(response).to redirect_to(contact_thanks_path)
    end

    it "re-renders the form with 422 on invalid input" do
      post "/contact", params: { contact: { name: "", email: "bad", message: "" } }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
