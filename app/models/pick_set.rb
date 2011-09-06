class PickSet < ActiveRecord::Base
  include Obfuscatable

  belongs_to :pool
  belongs_to :user
  belongs_to :week
  has_many :picks, :dependent => :destroy
  has_many :earned_badges

  attr_accessible :picks_attributes, :week_id, :pool_id

  accepts_nested_attributes_for :picks, :reject_if => lambda { |a| a[:is_home].blank? && a[:spread].blank? && a[:over_under].blank? && a[:is_over].blank? }
  validate :number_of_picks

  def number_of_picks
    max = pool.pool_type.max_picks
    unless max.nil?
      errors.add(:base, "You cannot have more than #{max} picks in a week for this pool") if picks.size > max
    end
  end

  def has_max_picks
    max = pool.pool_type.max_picks
    if max.nil?
      picks.size >= week.games.size
    else
      picks.size >= max
    end
  end

  def record
    standing = Standing.where("pool_id = ?", pool.id).where("week_id = ?", week_id).where("user_id = ?", user_id).first
    if standing
      [standing.wins, standing.losses, standing.pushes].join("-")
    else
      "0-0-0"
    end
  end

end
