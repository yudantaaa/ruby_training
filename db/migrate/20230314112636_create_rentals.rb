class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :rented_at
      t.datetime :due_date
      t.datetime :returned_at

      t.timestamps
    end
  end
end
