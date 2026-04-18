require "rails_helper"

RSpec.describe PostPolicy do
  def policy_for(record, user: nil)
    described_class.new(record, user: user)
  end

  it "allows guests to see a published post" do
    post = create(:post, :published)
    expect(policy_for(post).apply(:show?)).to be(true)
  end

  it "denies guests for a draft post" do
    post = create(:post)
    expect(policy_for(post).apply(:show?)).to be(false)
  end

  it "filters drafts from the relation scope" do
    published = create(:post, :published)
    create(:post)

    scope = described_class.new(Post.all, user: nil)
                           .apply_scope(Post.all, type: :active_record_relation)

    expect(scope.to_a).to contain_exactly(published)
  end
end
