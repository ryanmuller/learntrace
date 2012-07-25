class PinsController < ApplicationController
  before_filter :authenticate_user!

  def update
    @pin = current_user.pins.find(params[:id])
    @stream = @pin.stream
    if new_time = params[:pin][:scheduled_at] and not new_time.empty?
      @pin.update_attributes({ scheduled_at: Time.at(new_time.to_i), completed_at: nil })
    end
      
    respond_to do |format|
      format.js
    end
  end

  def create
    @item = Item.find(params[:pin][:item_id])
    # new stream
    if params[:pin][:stream] && !params[:pin][:stream].empty?
      @stream = current_user.streams.create(:name => params[:pin][:stream])
      @pin = current_user.pin_and_copy!(@item, @stream)
    # existing stream
    elsif params[:pin][:stream_id] && !params[:pin][:stream_id].empty?
      @stream = current_user.streams.find(params[:pin][:stream_id])
      @pin = current_user.pin_and_copy!(@item, @stream)
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @pin = Pin.find(params[:id])
    @item = @pin.item
    current_user.unpin!(@item)

    respond_to do |format|
      format.html { redirect_to @item }
      format.js 
    end
  end
end
