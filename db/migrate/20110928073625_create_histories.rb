class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :book
      t.references :user
      t.integer :action

      t.timestamps
    end
    add_index :histories, :book_id
    add_index :histories, :user_id
  end
end
