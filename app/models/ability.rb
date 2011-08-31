class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in @user here. For example:
    #
    #   @user ||= @user.new # guest @user (not logged in)
    #   if @user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the @user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the @user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the @user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    @user = user || User.new

    if user.role? :admin
      can :manage, :all
    elsif user.role? :pool_admin
      #TODO this isnt working
      # can :update, PoolUser do |pu|
      #   !pool_user.pool.pool_users.where('user_id = ?', user.id).where('pool_admin = ?', true).empty?
      # end

      can :update, Pool do |pool|
        !pool.pool_users.where('user_id = ?', user.id).where('pool_admin = ?', true).empty?
      end
      member
    elsif user.role? :member
      member
    end

  end

  def member
    can :read, Game
    can :read, Pool, :private => false

    can :read, Pool do |pool|
      @user.pools.include?(pool)
    end

    can :read, Standing do |standing|
      @user.pools.include?(standing.pool)
    end

    can [:create, :read], [PickSet, Pick]

    can :update, PickSet do |pick_set|
      @user.pick_sets.include?(pick_set) and pick_set.week.end_date > Time.now
    end

  end
end
