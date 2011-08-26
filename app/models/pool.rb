class Pool < ActiveRecord::Base
  include Obfuscatable

  belongs_to :pool_type
  has_many :pick_sets
  has_many :pool_users, :dependent => :destroy
  has_many :user, :through => :pool_users
  has_many :standings
  has_and_belongs_to_many :leagues

  validates_presence_of :pool_type_id, :name

  validate :cost_if_not_free
  validate :password_if_private

  def cost_if_not_free
    if free and cost.nil?
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

  def admins
    pool_users.where("pool_admin = ?", true).collect { |a| a.user.email }.join(", ")
  end

end
