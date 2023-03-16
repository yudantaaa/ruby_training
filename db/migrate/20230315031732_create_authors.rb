class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :pen_name, null:false
      t.references :book, null: false, foreign_key: true
      t.timestamps
    end
  end
end
