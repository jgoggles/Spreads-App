class Week < ActiveRecord::Base
  has_many :games
  has_many :pick_sets
  has_many :standings
end
