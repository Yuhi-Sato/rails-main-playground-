class PostPolicy < ApplicationPolicy
  pre_check :allow_published!, only: %i[show?]

  def show?
    admin? || record.published?
  end

  relation_scope do |relation|
    next relation if admin?
    relation.published
  end

  private

  def allow_published!
    allow! if record.respond_to?(:published?) && record.published?
  end
end
