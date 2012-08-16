class Week < ActiveRecord::Base
  belongs_to :year
  has_many :games
  has_many :pick_sets
  has_many :standings
  has_many :earned_badges

  def self.current
    if Time.now < Year.current.weeks.first.start_date
      Year.current.weeks.first
    else
      where("start_date <= ?", Time.now).where(["end_date >= ?", Time.now]).first
    end
  end

  def self.previous
    if current.name.to_i > 1
      week = find(current.id - 1)
    else
      self.current
    end
  end
end
