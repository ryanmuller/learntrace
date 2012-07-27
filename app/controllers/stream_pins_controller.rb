class StreamPinsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def show
    @stream = Stream.find(params[:stream_id])
    #@stream = Stream.find(params[:id])
    @pin = Pin.find(params[:id])


    respond_to do |format|
      format.js
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @item = @pin.item
    current_user.unpin!(@pin)

    respond_to do |format|
      format.js 
    end
  end

  def update
    @pin = current_user.pins.find(params[:id])
    @pin.complete!

    respond_to do |format|
      format.js
    end
  end
end
