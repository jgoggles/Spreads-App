class TopicsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_pool
  load_and_authorize_resource :pool
  load_and_authorize_resource :topic, :through => :pool

  # GET /topics
  # GET /topics.json
  def index
    @topics = @pool.topics.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @messages = @topic.messages.order("created_at DESC")
    @message = Message.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = current_user.topics.build(params[:topic])
    @topic.pool_id = @pool.id

    respond_to do |format|
      if @topic.save
        format.html { redirect_to [@pool, @topic], notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to [@pool, @topic], notice: 'Topic was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to pool_topics_url }
      format.json { head :ok }
    end
  end

  private
  def load_pool
    @pool = Pool.find(params[:pool_id])
  end
end
