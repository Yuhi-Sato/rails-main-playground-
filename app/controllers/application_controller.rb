class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ActionPolicy::Controller

  allow_browser versions: :modern
  stale_when_importmap_changes

  authorize :user, through: :current_user

  helper_method :current_user, :site

  rescue_from ActionPolicy::Unauthorized, with: :forbidden

  private

  # No auth layer yet - future-proof hook.
  def current_user
    nil
  end

  def site
    @site ||= SiteConfig.new
  end

  def forbidden(_exception)
    render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
  end
end
