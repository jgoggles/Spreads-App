class WeeksController < ApplicationController
  load_and_authorize_resource

  def index
    @weeks = Week.all
  end

  def show
    @week = Week.find(params[:id])
  end

  def new
    @week = Week.new
  end

  def create
    @week = Week.new(params[:week])
    if @week.save
      redirect_to @week, :notice => "Successfully created week."
    else
      render :action => 'new'
    end
  end

  def edit
    @week = Week.find(params[:id])
  end

  def update
    @week = Week.find(params[:id])
    if @week.update_attributes(params[:week])
      redirect_to @week, :notice  => "Successfully updated week."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @week = Week.find(params[:id])
    @week.destroy
    redirect_to weeks_url, :notice => "Successfully destroyed week."
  end
end
