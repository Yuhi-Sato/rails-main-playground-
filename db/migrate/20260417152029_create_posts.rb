class CreatePosts < ActiveRecord::Migration[8.2]
  def change
    create_table :posts do |t|
      t.string   :title, null: false
      t.string   :slug, null: false
      t.text     :body
      t.datetime :published_at
      t.string   :tags, array: true, default: []
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :posts, :slug, unique: true
    add_index :posts, :published_at
    add_index :posts, :tags, using: :gin
    add_index :posts, :discarded_at
  end
end
