class StreamsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @streams = Stream.all
    
    respond_to do |format|
      format.html
      format.json { render json: @streams }
    end
  end

  def create
    @stream = current_user.streams.build(params[:stream])
    respond_to do |format|
      if @stream.save
        format.html { redirect_to @stream, notice: "You're ready to start learning!" }
        format.json { render json: @stream, status: :created, location: @stream }
      else
        format.html { render action: "index" }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy

    respond_to do |format|
      format.html { redirect_to streams_url }
      format.json { head :no_content }
    end
  end

  def show
    @stream = Stream.find(params[:id]) 
    @item = Item.new
    @tag = Tag.find_by_name(@stream.name.downcase)
    if @tag
      @suggested = @tag.items.featured
    end

    respond_to do |format|
      format.html
      format.json 
    end
  end

  def timeline
    @stream = Stream.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
    end
  end
end
