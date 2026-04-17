class ContactMailer < ApplicationMailer
  def notify(payload)
    @name    = payload[:name]
    @email   = payload[:email]
    @message = payload[:message]

    mail(
      to:       SiteConfig.new.owner_email,
      reply_to: @email,
      subject:  "[yuhi.dev] New message from #{@name}"
    )
  end
end
