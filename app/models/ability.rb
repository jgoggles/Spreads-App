class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new

    if user.role? :admin
      can :manage, :all
      can :access, :rails_admin
    elsif user.role? :pool_admin
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

    can [:create, :read], PickSet, :user_id => @user.id

    can :update, PickSet do |pick_set|
      @user.pick_sets.include?(pick_set) and pick_set.week.end_date > Time.now
    end

    can :create, Topic
    can :update, Topic, :user_id => @user.id
    can :read, Topic do |topic|
      @user.pools.include?(topic.pool)
    end

  end
end
