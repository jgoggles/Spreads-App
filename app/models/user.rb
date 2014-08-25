class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  include Obfuscatable

  has_and_belongs_to_many :roles
  has_many :authentications, :dependent => :destroy
  has_many :pool_users, :dependent => :destroy
  has_many :pools, :through => :pool_users
  has_many :pick_sets, :dependent => :destroy
  has_many :standings
  has_many :topics
  has_many :messages
  has_many :earned_badges, :dependent => :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :favorite_nfl_team_id

  after_create :add_default_role

  def active_pools
    self.pools.select { |p| p.year == Year.current }
  end

  def name
    [first_name, last_name].join(" ")
  end

  def display_name
    if !first_name.blank? or !last_name.blank?
      [first_name, last_name].join(" ").strip
    else
      email
    end
  end

  def to_json(options = {})
    {
      id: self.id,
      display_name: self.display_name
    }
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    self.first_name = omniauth['user_info']['first_name'] if first_name.blank?
    self.last_name = omniauth['user_info']['last_name'] if last_name.blank?
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

  def pool_admin?(pool)
    if pools.include?(pool)
      role?(:pool_admin) and pool_users.where("pool_id = ?", pool.id).first.pool_admin?
    else
      return false
    end
  end

  def admin?
    role?(:admin)
  end

  def picks_made(pool)
    pick_set_for_this_week(pool).picks.size rescue 0
  end

  def pick_set_for_this_week(pool)
    pick_sets.where('week_id = ?', Week.current).where('pool_id = ?', pool.id).first
  end

  def process_non_picks(pool, options = { :week => Week.previous })
    week = options[:week]
    min_picks = pool.min_picks
    week_pick_sets = pick_sets.where("week_id = ?", week.id).where("pool_id = ?", pool.id)

    if !pool.pool_type.over_under?
      o_u = nil
      o_u_result = nil
    else
      o_u = 0
      o_u_result = -1
    end

    # if there is no pick set, create one with all losing picks
    if week_pick_sets.empty?
      pick_set = pick_sets.create(:week_id => week.id, :pool_id => pool.id)
      min_picks.times do
        pick_set.picks.create(:spread => 0, :result => -1, :team_id => 0, :game_id => 0, :over_under => o_u, :over_under_result => o_u_result)
      end
    else # if there is a pick set but < the min picks needed, create losses for each non pick
      week_pick_sets.each do |ps|
        if ps.week.end_date < Week.current.start_date
          if ps.unit_size < min_picks
            losses = min_picks - ps.unit_size
            losses.times { ps.picks.create(:spread => 0, :result => -1, :team_id => 0, :game_id => 0, :over_under => o_u, :over_under_result => o_u_result)}
          end

          # for o/u leagues, create a loss for each spread or o/u non pick
          if pool.pool_type.over_under?
            ps.picks.each do |p|
              unless p.complete?
                if p.spread.nil?
                  p.spread = 0
                  p.result = -1
                else
                  p.over_under = 0
                  pover_under_result = -1
                end
                p.save
              end
            end
          end
        end
      end
    end
  end

  private
  def add_default_role
    self.roles << Role.find_or_create_by_name("Member")
  end

end
