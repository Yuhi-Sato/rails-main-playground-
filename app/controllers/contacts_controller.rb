class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    case ContactSubmission.call(@contact)
    in Dry::Monads::Success
      redirect_to contact_thanks_path
    in Dry::Monads::Failure
      render :new, status: :unprocessable_content
    end
  end

  def thanks; end

  private

  def contact_params
    params.fetch(:contact, {}).permit(:name, :email, :message)
  end
end
