class CreateContactShares < ActiveRecord::Migration
  def change
    create_table :contact_shares do |t|
      t.integer :user_id, presence: true
      t.integer :contact_id, presence: true

      t.timestamps
    end

    add_index :contact_shares, :user_id
    add_index :contact_shares, :contact_id
    add_index :contact_shares, [:user_id, :contact_id], unique: true
  end
end
