class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      ContactMailer.notify(@contact.to_h).deliver_later
      redirect_to contact_thanks_path
    else
      render :new, status: :unprocessable_content
    end
  end

  def thanks; end

  private

  def contact_params
    params.fetch(:contact, {}).permit(:name, :email, :message)
  end
end
