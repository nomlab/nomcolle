class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :isbn13
      t.integer :price
      t.integer :page
      t.integer :width
      t.integer :height
      t.integer :depth
      t.integer :status

      t.timestamps
    end
  end
end
