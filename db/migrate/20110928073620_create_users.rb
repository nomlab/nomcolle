class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :login_name
      t.string :password
      t.string :description

      t.timestamps
    end
  end
end
