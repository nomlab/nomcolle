class IndividualController < ApplicationController
  def index
    @histories = History.where(:user_id => User.current)
    @reviews = Review.where(:user_id => User.current)
    @total_point = History.my_total_point
  end

end
