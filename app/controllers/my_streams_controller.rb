class MyStreamsController < ApplicationController

  def index
    @streams = current_user.streams

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @stream = Stream.includes(:pins => :item).find(params[:id])
    if @stream.user != current_user
      if params[:pin_id].nil?
        redirect_to stream_path(:id => params[:id])
      else
        redirect_to pin_stream_path(@stream, :pin_id => params[:pin_id])
      end
      return
    end

    @item = Item.new
    unless @stream.pins.empty?
      if @stream.pins.todo.empty?
        @display_pin = params[:pin_id].nil? ? @stream.pins.first : Pin.find(params[:pin_id]) 
      else
        @display_pin = params[:pin_id].nil? ? @stream.pins.todo.first : Pin.find(params[:pin_id]) 
      end
    end

    respond_to do |format|
      format.html
      format.json 
    end
  end
end
