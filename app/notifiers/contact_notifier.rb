class ContactNotifier < ApplicationNotifier
  self.driver = ->(data) { Rails.logger.info("[contact-notifier] #{data[:body]}") }

  def notify(name:, email:, message:)
    notification(
      body: "New contact from #{name} <#{email}>: #{message.truncate(140)}"
    )
  end
end
