class ContactMailer < ApplicationMailer
  def notify(name:, email:, message:)
    @name    = name
    @email   = email
    @message = message

    mail(
      to:       SiteConfig.new.owner_email,
      reply_to: @email,
      subject:  "[yuhi.dev] New message from #{@name}"
    )
  end
end
