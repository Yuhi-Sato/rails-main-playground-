class AddStatusToPosts < ActiveRecord::Migration[8.2]
  def change
    add_column :posts, :status, :string, null: false, default: "draft"
    add_index  :posts, :status

    reversible do |dir|
      dir.up do
        execute(<<~SQL)
          UPDATE posts SET status = 'published'
          WHERE discarded_at IS NULL
            AND published_at IS NOT NULL
            AND published_at <= now();
        SQL
      end
    end
  end
end
