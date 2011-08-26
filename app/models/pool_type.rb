class PoolType < ActiveRecord::Base
  has_many :pools

  validates_presence_of :name, :min_picks

  validate :check_double_false_game_type

  def check_double_false_game_type
    errors[:base] << "You must choose either Spreads or Over/Under" unless spreads? or over_under?
  end
end
