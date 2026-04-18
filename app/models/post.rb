class Post < ApplicationRecord
  include Discard::Model

  has_logidze

  STATES = %w[draft published archived].freeze

  state_machine :status, initial: :draft do
    event :publish do
      transition %i[draft archived] => :published
    end

    event :archive do
      transition published: :archived
    end

    event :unpublish do
      transition published: :draft
    end

    after_transition on: :publish do |post|
      post.update_column(:published_at, Time.current) if post.published_at.nil?
    end
  end

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true

  before_validation :ensure_slug

  scope :published, -> { kept.where(status: :published).where(published_at: ..Time.current) }
  scope :recent, -> { order(published_at: :desc, created_at: :desc) }

  def to_param = slug

  def self.published_count_via_fx
    connection.select_value("SELECT posts_published_count()").to_i
  end

  private

  def ensure_slug
    return if slug.present?
    self.slug = title.to_s.parameterize.presence || Nanoid.generate(size: 10)
  end
end
