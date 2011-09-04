class PoolUser < ActiveRecord::Base
  belongs_to :pool
  belongs_to :user

  attr_accessor :password

  validate :check_password

  after_save :process_admins

  scope :paid, :conditions => {:paid => true}

  def check_password
    if pool.private? and password != pool.password and new_record?
      errors[:base] << "Incorrect password"
    end
  end

  private
  def process_admins
    role = Role.find_by_name("PoolAdmin")
    unless user.roles.include?(role) && user.pool_users.where("pool_admin = ?", true).size >= 1
      if pool_admin
        user.roles << role
      else
        user.roles.delete(role)
      end
    end
  end
end
