class PathsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @paths = current_user.paths
    @tag_data = Tag.all.map{|t| t.name }.join(",")
  end

  def create
    @path = current_user.paths.build(params[:path])
    respond_to do |format|
      if @path.save
        format.html { redirect_to @path, notice: "You're ready to start learning!" }
        format.json { render json: @path, status: :created, location: @path }
      else
        format.html { render action: "index" }
        format.json { render json: @path.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @path = Path.find(params[:id])
    @path.destroy

    respond_to do |format|
      format.html { redirect_to paths_url }
      format.json { head :no_content }
    end
  end

  def show
    @path = Path.find(params[:id]) 
  end
end
