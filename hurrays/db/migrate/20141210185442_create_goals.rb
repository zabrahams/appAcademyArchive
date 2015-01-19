class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title,      null: false
      t.text :body,         null: false
      t.integer :author_id, null: false
      t.boolean :pub_status,null: false
      t.boolean :completed, null: false

      t.timestamps
    end

    add_index :goals, [:title, :author_id], unique: true
    add_index :goals, :author_id, unique: true
  end
end
