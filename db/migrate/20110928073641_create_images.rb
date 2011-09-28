class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :book
      t.string :path

      t.timestamps
    end
    add_index :images, :book_id
  end
end
