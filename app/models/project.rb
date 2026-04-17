class Project < ApplicationRecord
  include Discard::Model

  validates :title, presence: true

  scope :featured_first, -> { kept.order(featured: :desc, position: :asc) }
  scope :ordered, -> { kept.order(position: :asc, created_at: :desc) }

  def tech_list
    tech_stack.to_s.split(",").map(&:strip).reject(&:empty?)
  end
end
