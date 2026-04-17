class Skill < ApplicationRecord
  CATEGORIES = %w[language framework database devops tool other].freeze

  validates :name, :category, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :level, numericality: { only_integer: true, in: 1..5 }

  scope :ordered, -> { order(position: :asc, name: :asc) }
  scope :by_category, ->(category) { where(category: category) }
end
