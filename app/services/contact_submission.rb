class ContactSubmission < ApplicationService
  include AfterCommitEverywhere

  MAX_ATTEMPTS = 3

  def call(contact)
    return Failure(errors: contact.errors) unless contact.valid?

    ActiveRecord::Base.transaction do
      after_commit { deliver(contact) }
    end

    Success(contact)
  end

  private

  # Retriable handles transient errors; Stoplight short-circuits after
  # too many failures so we don't hammer a downstream that is clearly
  # down (e.g. notification provider outage).
  def deliver(contact)
    light = Stoplight("contact-delivery")
    light.run do
      Retriable.retriable(tries: MAX_ATTEMPTS, base_interval: 0.01, on: StandardError) do
        ContactDelivery
          .with(payload: contact.to_h)
          .notify(:notify, name: contact.name, email: contact.email, message: contact.message)
      end
    end
  end
end
