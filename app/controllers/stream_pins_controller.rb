class StreamPinsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def show
    @stream = Stream.find(params[:stream_id])
    @pin = Pin.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @stream = @pin.stream
    @item = @pin.item
    current_user.unpin!(@pin)

    respond_to do |format|
      format.js 
    end
  end

  def update
    @pin = current_user.pins.find(params[:id])
    @pin.complete!
    @stream = @pin.stream

    respond_to do |format|
      format.js
    end
  end
end
