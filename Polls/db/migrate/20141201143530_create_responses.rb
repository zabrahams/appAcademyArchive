class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :answer_choice_id
      t.integer :user_id
      t.timestamps
    end

    add_index :responses, [:user_id, :answer_choice_id]
  end
end
