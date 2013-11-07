class BowlingScore < ActiveRecord::Base
  belongs_to :bowling_match
  belongs_to :user
  belongs_to :bowling_team
end
