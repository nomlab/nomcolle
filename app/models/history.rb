class History < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  
  def self.my_total_point
    total_point = {:page => 0, :price => 0, :depth => 0}
    @histories = History.where(:user_id => User.current)
    @histories.each do |history|
      book = history.book
      total_point[:page] += book.page
      total_point[:price] += book.price
      total_point[:depth] += book.depth
    end
    return total_point
  end
end
