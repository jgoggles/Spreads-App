class PoolTypesController < ApplicationController
  load_and_authorize_resource

  # GET /pool_types
  # GET /pool_types.json
  def index
    @pool_types = PoolType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pool_types }
    end
  end

  # GET /pool_types/1
  # GET /pool_types/1.json
  def show
    @pool_type = PoolType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pool_type }
    end
  end

  # GET /pool_types/new
  # GET /pool_types/new.json
  def new
    @pool_type = PoolType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pool_type }
    end
  end

  # GET /pool_types/1/edit
  def edit
    @pool_type = PoolType.find(params[:id])
  end

  # POST /pool_types
  # POST /pool_types.json
  def create
    @pool_type = PoolType.new(params[:pool_type])

    respond_to do |format|
      if @pool_type.save
        format.html { redirect_to @pool_type, notice: 'Pool type was successfully created.' }
        format.json { render json: @pool_type, status: :created, location: @pool_type }
      else
        format.html { render action: "new" }
        format.json { render json: @pool_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pool_types/1
  # PUT /pool_types/1.json
  def update
    @pool_type = PoolType.find(params[:id])

    respond_to do |format|
      if @pool_type.update_attributes(params[:pool_type])
        format.html { redirect_to @pool_type, notice: 'Pool type was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pool_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pool_types/1
  # DELETE /pool_types/1.json
  def destroy
    @pool_type = PoolType.find(params[:id])
    @pool_type.destroy

    respond_to do |format|
      format.html { redirect_to pool_types_url }
      format.json { head :ok }
    end
  end
end
