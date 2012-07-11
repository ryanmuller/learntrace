class PinsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @pins = current_user.pins
    @item = Item.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pins }
    end
  end

  def update
    @pin = current_user.pins.find(params[:id])
    @pin.update_attributes({ :status => params[:pin][:status] })
    respond_to do |format|
      format.js   { render :nothing => true } 
    end
  end

  def create
    @item = Item.find(params[:pin][:item_id])
    current_user.pin!(@item)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @item = Pin.find(params[:id]).item
    current_user.unpin!(@item)
    redirect_to @item
  end
end
