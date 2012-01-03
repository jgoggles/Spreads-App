class PickSetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_current_week
  load_and_authorize_resource :pool
  load_and_authorize_resource :pick_set, :through => :pool, :except => [:show, :edit, :update]

  before_filter :load_pool_and_title
  before_filter :load_pool_rules
  before_filter :check_for_current_week_pick_set, :only => :new
  before_filter :check_for_paid

  # GET /pick_sets/1
  # GET /pick_sets/1.json
  def show
    @pick_set = PickSet.find(params[:id])
    authorize! :read, @pick_set

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pick_set }
    end
  end

  # GET /pick_sets/new
  # GET /pick_sets/new.json
  def new
    @pick_set = PickSet.new
    @games = Game.with_spreads
    @units_remaining = @pool.pool_type.max_picks

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pick_set }
    end
  end

  # GET /pick_sets/1/edit
  def edit
    @pick_set = PickSet.find(params[:id])
    @games = Game.with_spreads(current_user, @pool)
    @units_remaining = @pick_set.units_remaining
    authorize! :update, @pick_set
  end

  # POST /pick_sets
  # POST /pick_sets.json
  def create
    @pick_set = current_user.pick_sets.build(params[:pick_set])
    @pick_set.week_id = @week.id
    @pick_set.pool_id = @pool.id
    @games = Game.with_spreads
    @units_remaining = @pool.pool_type.max_picks

    respond_to do |format|
      if @pick_set.save
        if @pool.pool_type.allow_same_game
        end
        format.html { redirect_to [@pool, @pick_set], notice: 'Pick set was successfully created.' }
        format.json { render json: @pick_set, status: :created, location: @pick_set }
      else
        format.html { render action: "new" }
        format.json { render json: @pick_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pick_sets/1
  # PUT /pick_sets/1.json
  def update
    @pick_set = PickSet.find(params[:id])
    @games = Game.with_spreads(current_user, @pool)
    authorize! :update, @pick_set
    @units_remaining = @pick_set.units_remaining

    respond_to do |format|
      if @pick_set.update_attributes(params[:pick_set])
        format.html { redirect_to [@pool, @pick_set], notice: 'Pick set was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pick_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pick_sets/1
  # DELETE /pick_sets/1.json
  def destroy
    @pick_set = PickSet.find(params[:id])
    @pick_set.destroy

    respond_to do |format|
      format.html { redirect_to pool_pick_sets_url }
      format.json { head :ok }
    end
  end

  private
  def load_pool_and_title
    @pool = Pool.find(params[:pool_id])
    @title = "Week #{@week.name} picks"
  end

  def load_pool_rules
    @has_over_under = @pool.pool_type.over_under
    @has_spreads = @pool.pool_type.spreads
    @max_picks = @pool.pool_type.max_picks
    @min_picks = @pool.pool_type.min_picks
  end

  def check_for_current_week_pick_set
    unless current_user.pick_set_for_this_week(@pool).nil?
      pick_set = current_user.pick_set_for_this_week(@pool)
      redirect_to edit_pool_pick_set_path(@pool, pick_set)
    end
  end

  def check_for_paid
    if !@pool.free? and !current_user.pool_admin?(@pool)
      if !@pool.pool_users.where("user_id = ?", current_user.id).first.paid?
        redirect_to pool_path(@pool)
        flash[:notice] = "You need to pay your pool entry fee before being able to make picks."
      end
    end
  end
end
