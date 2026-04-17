class PostCardComponent < ApplicationComponent
  extend Dry::Initializer

  option :post

  def formatted_date
    return "Draft" unless post.published_at
    post.published_at.strftime("%Y-%m-%d")
  end

  def excerpt
    post.body.to_s.split("\n").find { |line| !line.strip.empty? }.to_s
  end
end
