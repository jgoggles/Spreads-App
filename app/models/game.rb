class Game < ActiveRecord::Base
  attr_accessible :date, :week_id, :game_details_attributes

  belongs_to :week
  has_many :game_details, :dependent => :destroy
  has_many :teams, :through => :game_details
  has_many :picks

  accepts_nested_attributes_for :game_details

  def home
    self.teams.where("is_home = ?", true)[0]
  end

  def away
    self.teams.where("is_home = ?", false)[0]
  end

  def home_score
    self.game_details.where("is_home = ?", true).first.score
  end

  def away_score
    self.game_details.where("is_home = ?", false).first.score
  end
end
