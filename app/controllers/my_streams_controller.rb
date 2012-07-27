class MyStreamsController < ApplicationController

  def index
    @streams = current_user.streams

    respond_to do |format|
      format.json
    end
  end

  def show
    @stream = current_user.streams.find(params[:id]) 
    if @stream.nil?
      redirect_to stream_path(:id => params[:id])
      return
    end

    @item = Item.new
    unless @stream.pins.empty?
      @display_pin = params[:pin_id].nil? ? @stream.pins.todo.first : Pin.find(params[:pin_id]) 
    end

    respond_to do |format|
      format.html
      format.json 
    end
  end
end
