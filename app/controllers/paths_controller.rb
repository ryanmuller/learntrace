class PathsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @paths = current_user.paths
    @path = current_user.paths.build
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

  def show
    @path = Path.find(params[:id]) 
  end
end
