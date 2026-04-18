require "rails_helper"

RSpec.describe ProjectPolicy do
  it "hides discarded projects from guests" do
    kept      = create(:project)
    _discarded = create(:project, :discarded)

    scope = ProjectPolicy.new(nil, user: nil).apply_scope(Project.all, type: :active_record_relation)
    expect(scope.to_a).to contain_exactly(kept)
  end
end
