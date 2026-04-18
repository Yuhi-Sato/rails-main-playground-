require "rails_helper"

RSpec.describe Post::Publisher do
  before { AbstractNotifier::Testing::Driver.clear }

  it "is accessible via post.publisher (associated_object)" do
    post = create(:post)
    expect(post.publisher).to be_a(described_class)
    expect(post.publisher.post).to eq(post)
  end

  it "enqueues a notification when called" do
    post = create(:post)

    expect {
      post.publisher.call
    }.to change {
      AbstractNotifier::Testing::Driver.enqueued_deliveries.size
    }.by(1)
  end
end
