class Post < ApplicationRecord
  include Discard::Model
  include PgSearch::Model

  has_logidze
  has_object :publisher

  store_attribute :metadata, :reading_time, :integer, default: 5
  store_attribute :metadata, :canonical_url, :string
  store_attribute :metadata, :cover_alt, :string

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

  performs :publish

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true
  validates :reading_time, numericality: { greater_than: 0, only_integer: true }

  before_validation :ensure_slug

  scope :published, -> { kept.where(status: :published).where(published_at: ..Time.current) }
  scope :recent, -> { order(published_at: :desc, created_at: :desc) }

  pg_search_scope :search_text,
    against: { title: "A", body: "B" },
    using:  { tsearch: { prefix: true, dictionary: "english" } }

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
