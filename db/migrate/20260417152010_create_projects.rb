class CreateProjects < ActiveRecord::Migration[8.2]
  def change
    create_table :projects do |t|
      t.string  :title, null: false
      t.text    :description
      t.string  :tech_stack
      t.string  :url
      t.string  :github_url
      t.boolean :featured, default: false, null: false
      t.integer :position, default: 0, null: false
      t.datetime :discarded_at

      t.timestamps
    end

    add_index :projects, :discarded_at
    add_index :projects, :featured
  end
end
