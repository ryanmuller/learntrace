class LibraryController < ApplicationController
  before_filter :authenticate_user!

  def index
    @items = current_user.items
    @item = Item.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end
end
