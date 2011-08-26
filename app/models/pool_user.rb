class PoolUser < ActiveRecord::Base
  belongs_to :pool
  belongs_to :user

  attr_accessor :password

  validate :check_password

  def check_password
    if pool.private? and password != pool.password
      errors[:base] << "Incorrect password"
    end
  end
end
