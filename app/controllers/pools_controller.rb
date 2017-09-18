class PoolsController < ApplicationController
  load_and_authorize_resource :except => [:show, :achievements, :rules]

  before_filter :authenticate_user!
  before_filter :load_current_week

  # GET /pools
  # GET /pools.json
  def index
    if current_user.god?
      @pools = Pool.all
    else
      @pools = current_user.pools
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pools }
    end
  end

  # GET /pools/1
  # GET /pools/1.json
  def show
    @pool = Pool.find(params[:id])
    @badges = current_user.earned_badges.where("pool_id = ?", @pool.id).select("DISTINCT(badge_id)")
    @messages = @pool.topics.order("updated_at DESC")
    @pick_set = current_user.pick_set_for_this_week(@pool)
    @next_week_pick_set = current_user.pick_set_for_next_week(@pool)
    @users = @pool.users.map { |u| {name: u.display_name, picks_made: u.picks_made(@pool)} }.sort_by { |h| -h[:picks_made] }
    if !current_user.pools.include?(@pool)
      @pool_user = PoolUser.new
    else
      @pool_user = current_user.pools.where(id: @pool.id).first
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pool }
    end
  end

  # GET /pools/new
  # GET /pools/new.json
  def new
    @pool = Pool.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pool }
    end
  end

  # GET /pools/1/edit
  def edit
    @pool = Pool.find(params[:id])
  end

  # POST /pools
  # POST /pools.json
  def create
    @pool = Pool.new(pool_params)
    @pool.year = Year.current

    respond_to do |format|
      if @pool.save
        current_user.pool_users.create(pool_id: @pool.id, pool_admin: true, password: @pool.password)
        format.html { redirect_to @pool, notice: 'Pool was successfully created.' }
        format.json { render json: @pool, status: :created, location: @pool }
      else
        format.html { render action: "new" }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pools/1
  # PUT /pools/1.json
  def update
    @pool = Pool.find(params[:id])

    respond_to do |format|
      if @pool.update_attributes!(pool_params)
        format.html { redirect_to @pool, notice: 'Pool was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pools/1
  # DELETE /pools/1.json
  def destroy
    @pool = Pool.find(params[:id])
    @pool.destroy

    respond_to do |format|
      format.html { redirect_to pools_url }
      format.json { head :ok }
    end
  end

  def achievements
    @pool = Pool.find(params[:id])
    # @badges = current_user.earned_badges.where("pool_id = ?", @pool.id).select("DISTINCT(badge_id)")
    @badges = current_user.earned_badges.where("pool_id = ?", @pool.id)
  end

  def rules
    @pool = Pool.find(params[:id])
  end

  private

  def pool_params
    params.require(:pool).permit(:name, :pool_type_id, :min_players, :max_players, :private, :password, :free, :cost, :first_place_payout, :second_place_payout, :third_place_payout, :fourth_place_payout, :fifth_place_payout)
  end
end
