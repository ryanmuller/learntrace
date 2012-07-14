class BookmarkletController < ApplicationController
  before_filter :authenticate_user!

  def learned
    @pin = current_user.pins.joins(:item).merge(Item.where(:url => params[:url])).first

    if @pin
      render :layout => false
    else 
      redirect_to new_item_url(:url => params[:url], :name => params[:name]), alert: "You have not saved this URL. Create a new item instead?"
    end
  end
end
