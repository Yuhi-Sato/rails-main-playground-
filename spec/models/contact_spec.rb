require "rails_helper"

RSpec.describe Contact, type: :model do
  it "accepts a well-formed contact" do
    expect(build(:contact)).to be_valid
  end

  it "validates email format and message length" do
    expect(build(:contact, email: "nope")).not_to be_valid
    expect(build(:contact, message: "short")).not_to be_valid
    expect(build(:contact, name: "")).not_to be_valid
  end
end
