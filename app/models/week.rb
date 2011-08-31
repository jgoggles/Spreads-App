class Week < ActiveRecord::Base
  has_many :games
  has_many :pick_sets
  has_many :standings

  def self.current
    if Time.now < Week.first.start_date
      find(1)
    else
      where("start_date <= ?", Time.now).where(["end_date >= ?", Time.now]).first
    end
  end

  def self.previous
    if current.id > 1
      week = find(current.id - 1)
    end
  end
end
