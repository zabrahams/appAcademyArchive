class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
