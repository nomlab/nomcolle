class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  validates(:stars, :inclusion => { :in => 0..10 } )
  validates :book_id, :user_id, presence: true
end
