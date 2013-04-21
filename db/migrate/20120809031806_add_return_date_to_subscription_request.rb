class AddReturnDateToSubscriptionRequest < ActiveRecord::Migration
  def change
    add_column :subscription_requests, :return_date, :datetime
  end
end
