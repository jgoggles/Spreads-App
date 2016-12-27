class Week < ActiveRecord::Base
  belongs_to :year
  has_many :games
  has_many :pick_sets
  has_many :standings
  has_many :earned_badges

  attr_accessible :name, :start_date, :end_date, :year_id


  def self.current
    if Time.now < Year.current.weeks.first.start_date
      week = Year.current.weeks.first
    else
      week = Year.current.weeks.where("start_date <= ?", Time.now).where(["end_date >= ?", Time.now]).first
    end
    week ||= Year.current.weeks.last
  end

  def self.previous
    week = self.current
    if week.name.to_i > 1 && !week.is_offseason?
      week = Year.current.weeks.find_by(name: (week.name.to_i - 1).to_s)
    end
    week
  end

  def is_week_one?
    if self.year == Year.current
      return self.name == '1'
    end
    false
  end

  def is_last_week_of_season?
    self.name.to_i == 17
  end

  def is_offseason?
    (Time.now < self.year.weeks.first.start_date && Time.now < Year::LINES_OPEN) || Time.now > self.year.weeks.last.end_date
  end

  def is_week_one_or_offseason?
    is_week_one? || is_offseason?
  end

  def pick_cutoff_passed?
    return false if Time.now < Year.last.weeks.first.start_date
    return true if Date.today.sunday? && (Time.now > Chronic.parse('10am'))
    return true if Date.today.monday?
    false
  end
end
