class Pool < ActiveRecord::Base
  include Obfuscatable

  belongs_to :pool_type
  belongs_to :year
  has_many :pick_sets
  has_many :picks, :through => :pick_sets
  has_many :pool_users, :dependent => :destroy
  has_many :users, :through => :pool_users
  has_many :standings
  has_many :topics
  has_many :earned_badges
  has_and_belongs_to_many :leagues

  validates_presence_of :pool_type_id, :name

  validate :cost_if_not_free
  validate :password_if_private

  def over?
    !self.year.current? || Time.now > self.year.weeks.last.end_date
  end

  def cost_if_not_free
    if !free and cost.nil?
      errors[:base] << "You must enter a cost for your paid league"
    end
  end

  def password_if_private
    if private and password.blank?
      errors[:base] << "Private leagues must have a password"
    end
  end

  def total_players
    self.pool_users.size
  end

  def max_picks
    pool_type.max_picks.nil? ? "Unlimited" : pool_type.max_picks
  end

  def min_picks
    pool_type.min_picks
  end

  def admins
    pool_users.where("pool_admin = ?", true).collect { |a| a.user.display_name }
  end

  def pick_total
    n = 0
    Pick.joins(:pick_set).where("pool_id = ?", id).where("week_id = ?", Week.current.id).each { |p| (n += p.count) rescue n += 1 }
    n
  end

  def all_picks_in
    if pool_type.max_picks.nil?
      return false
    else
      pick_total >= total_players * max_picks
    end
  end
end
