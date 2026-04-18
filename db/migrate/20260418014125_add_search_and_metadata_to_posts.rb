class AddSearchAndMetadataToPosts < ActiveRecord::Migration[8.2]
  # strong_migrations can yell about missing defaults — we opt in explicitly.
  disable_ddl_transaction!

  def change
    safety_assured do
      add_column :posts, :metadata, :jsonb, default: {}, null: false
      add_column :posts, :search_vector, :tsvector
    end
    add_index :posts, :search_vector, using: :gin, algorithm: :concurrently
    add_index :posts, :metadata,      using: :gin, algorithm: :concurrently
  end
end
