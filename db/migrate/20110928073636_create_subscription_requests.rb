class CreateSubscriptionRequests < ActiveRecord::Migration
  def change
    create_table :subscription_requests do |t|
      t.references :book
      t.references :user
      t.text :description

      t.timestamps
    end
    add_index :subscription_requests, :book_id
    add_index :subscription_requests, :user_id
  end
end
