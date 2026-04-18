class PostResource
  include Alba::Resource

  attributes :slug, :title, :status, :tags

  attribute :published_at do |post|
    post.published_at&.iso8601
  end

  attribute :reading_time do |post|
    post.reading_time
  end

  attribute :url do |post|
    host = params[:host]
    host ? "#{host}/posts/#{post.slug}" : nil
  end
end
