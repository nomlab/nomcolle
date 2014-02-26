class AddShoeSizeToUser < ActiveRecord::Migration
  def change
    add_column :users, :shoe_size, :float
  end
end
