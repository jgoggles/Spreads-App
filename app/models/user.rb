class User < ActiveRecord::Base
  include Obfuscatable

  has_and_belongs_to_many :roles
  has_many :authentications, :dependent => :destroy
  has_many :pool_users, :dependent => :destroy
  has_many :pools, :through => :pool_users
  has_many :pick_sets
  has_many :standings

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  after_create :add_default_role

  def name
    [first_name, last_name].join(" ")
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  # so devise wont require password to edit account if the user has connected with other services (twitter, fb, google, etc)
  def update_with_password(params={})
    if authentications.empty?
      super
    else
      params.delete(:current_password)
      self.update_without_password(params)
    end
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def join_pool(pool, options = { :admin => false, :pool_password => nil })
    if pool.private?
      if options[:pool_password] != pool.password
        return false
      end
    end
    PoolUser.create!(pool_id: pool.id, user_id: id, pool_admin: options[:admin])
  end
  private
  def add_default_role
    self.roles << Role.find_or_create_by_name("Member")
  end

end
