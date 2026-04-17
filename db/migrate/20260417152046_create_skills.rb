class CreateSkills < ActiveRecord::Migration[8.2]
  def change
    create_table :skills do |t|
      t.string  :name, null: false
      t.string  :category, null: false
      t.integer :level, default: 3, null: false
      t.integer :position, default: 0, null: false

      t.timestamps
    end

    add_index :skills, :category
  end
end
