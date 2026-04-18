require "rails_helper"

RSpec.describe ContactSubmission, "Stoplight circuit breaker" do
  it "stops calling ContactDelivery once the circuit flips to red" do
    call_count = 0
    allow(ContactDelivery).to receive(:with) do |**_|
      call_count += 1
      raise "downstream boom"
    end

    # Threshold is 3 by default; fire enough failures to open the light.
    10.times do
      described_class.call(build(:contact))
    rescue StandardError
      nil
    end

    calls_before_guard = call_count

    # Hit it a few more times: the circuit is now red so ContactDelivery
    # should NOT be invoked again.
    3.times do
      described_class.call(build(:contact))
    rescue StandardError
      nil
    end

    expect(call_count).to eq(calls_before_guard)
  end
end
