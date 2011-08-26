class Team < ActiveRecord::Base
  belongs_to :league
  belongs_to :conference
  belongs_to :division
  has_many :game_details
  has_many :games, :through => :game_details
  has_many :picks

  def full_name
    [city, nickname].join(" ")
  end

end
