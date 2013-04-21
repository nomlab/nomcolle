class AddRentalDateToSubscriptionRequest < ActiveRecord::Migration
  def change
    add_column :subscription_requests, :rental_date, :datetime
  end
end
