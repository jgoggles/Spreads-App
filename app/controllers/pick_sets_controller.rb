class PickSetsController < ApplicationController
  load_and_authorize_resource

  before_filter :get_pool

  # GET /pick_sets
  # GET /pick_sets.json
  def index
    @pick_sets = PickSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pick_sets }
    end
  end

  # GET /pick_sets/1
  # GET /pick_sets/1.json
  def show
    @pick_set = PickSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pick_set }
    end
  end

  # GET /pick_sets/new
  # GET /pick_sets/new.json
  def new
    @pick_set = PickSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pick_set }
    end
  end

  # GET /pick_sets/1/edit
  def edit
    @pick_set = PickSet.find(params[:id])
  end

  # POST /pick_sets
  # POST /pick_sets.json
  def create
    @pick_set = PickSet.new(params[:pick_set])

    respond_to do |format|
      if @pick_set.save
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
  def get_pool
    @pool = Pool.find(params[:pool_id])
  end
end
