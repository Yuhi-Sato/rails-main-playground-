require "rails_helper"

RSpec.describe ContactSubmission do
  let(:contact) { build(:contact) }

  it "returns Failure when the contact is invalid" do
    result = described_class.call(build(:contact, email: "nope"))
    expect(result).to be_failure
    expect(result.failure[:errors]).to be_present
  end

  it "retries the delivery on transient failure and returns Success" do
    calls = 0
    delivery = class_double(ContactDelivery).as_stubbed_const
    allow(delivery).to receive(:with) do |**_kwargs|
      calls += 1
      raise "transient" if calls < 2
      instance_double(ActiveDelivery::Base).tap do |dbl|
        allow(dbl).to receive(:notify).and_return(true)
      end
    end

    result = described_class.call(contact)

    expect(result).to be_success
    expect(calls).to eq(2)
  end
end
