class StreamsController < ApplicationController

  before_filter :authenticate_user!, only: [:create, :destroy]

  def index
    @streams = Stream.popular
    
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
    @stream = Stream.includes(:pins => :item).find(params[:id]) 
    if @stream.user == current_user
      if params[:pin_id].nil?
        redirect_to my_stream_path(@stream)
      else
        redirect_to pin_my_stream_path(@stream, :pin_id => params[:pin_id])
      end
      return
    end
    unless @stream.pins.empty?
      @display_pin = params[:pin_id].nil? ? @stream.pins.first : Pin.find(params[:pin_id]) 
    end
    respond_to do |format|
      format.html
      format.json 
    end
  end

  def update
    @stream = current_user.streams.find(params[:id])
    @stream.update_attributes(params[:stream])
    respond_to do |format|
      format.js 
    end
  end
end
