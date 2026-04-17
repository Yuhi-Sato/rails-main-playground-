class Post < ApplicationRecord
  include Discard::Model

  has_logidze

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true

  before_validation :ensure_slug

  scope :published, -> { kept.where.not(published_at: nil).where(published_at: ..Time.current) }
  scope :recent, -> { order(published_at: :desc, created_at: :desc) }

  def to_param = slug

  def published?
    kept? && published_at.present? && published_at <= Time.current
  end

  private

  def ensure_slug
    return if slug.present?
    self.slug = title.to_s.parameterize.presence || Nanoid.generate(size: 10)
  end
end
