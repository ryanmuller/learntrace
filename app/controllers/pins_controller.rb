class PinsController < ApplicationController
  before_filter :authenticate_user!, :except => [:public_index]

  def index
    @pins = current_user.pins
    @item = Item.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pins }
    end
  end

  def library_items
    @pins = current_user.pins
  end

  def public_index
    @user = User.find(params[:user_id])
    @pins = @user.pins
    
    respond_to do |format|
      format.html
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
    @pin = Pin.find(params[:id])
    @item = @pin.item
    current_user.unpin!(@item)

    respond_to do |format|
      logger.debug(format.js)
      format.html { redirect_to @item }
      format.js 
    end
  end
end
