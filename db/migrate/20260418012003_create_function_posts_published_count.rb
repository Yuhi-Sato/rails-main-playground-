class CreateFunctionPostsPublishedCount < ActiveRecord::Migration[8.2]
  def change
    create_function :posts_published_count
  end
end
