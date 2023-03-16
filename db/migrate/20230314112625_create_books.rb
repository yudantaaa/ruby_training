class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.belongs_to :author
      t.text :description
      t.date :published_date
      t.boolean :status

      t.timestamps
    end
  end
end
