class PinsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @item = Item.find(params[:pin][:item_id])
    current_user.pin!(@item)
    redirect_to @item
  end

  def destroy
    @item = Pin.find(params[:id]).item
    current_user.unpin!(@item)
    redirect_to @item
  end
end
