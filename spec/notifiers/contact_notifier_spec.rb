require "rails_helper"

RSpec.describe ContactNotifier do
  before { AbstractNotifier::Testing::Driver.clear }

  it "captures the notification payload synchronously" do
    ContactNotifier.notify(
      name:    "Alice",
      email:   "alice@example.com",
      message: "Hello from the void"
    ).notify_now

    payload = AbstractNotifier::Testing::Driver.deliveries.last
    expect(payload[:body]).to include("Alice", "alice@example.com", "Hello from the void")
  end

  it "enqueues the notification with notify_later" do
    expect {
      ContactNotifier.notify(
        name:    "Bob",
        email:   "bob@example.com",
        message: "Later delivery please"
      ).notify_later
    }.to change { AbstractNotifier::Testing::Driver.enqueued_deliveries.size }.by(1)
  end
end
