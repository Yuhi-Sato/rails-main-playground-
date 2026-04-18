class Api::BaseController < ActionController::API
  include Pagy::Backend
  include ActionPolicy::Controller
  authorize :user, through: :current_user

  private

  def current_user = nil
end
