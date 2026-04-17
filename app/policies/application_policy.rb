class ApplicationPolicy < ActionPolicy::Base
  authorize :user, optional: true

  def index?  = true
  def show?   = true
  def create? = admin?
  def update? = admin?
  def destroy? = admin?

  private

  def admin?
    user.present? && user.respond_to?(:admin?) && user.admin?
  end
end
