class ProjectPolicy < ApplicationPolicy
  relation_scope do |relation|
    next relation if admin?
    relation.kept
  end
end
