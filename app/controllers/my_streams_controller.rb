class MyStreamsController < ApplicationController

  def show
    @stream = current_user.streams.find(params[:id]) 
    @item = Item.new
    @tag = Tag.find_by_name(@stream.name.downcase)
    if @tag
      @suggested = @tag.items.featured
    end

    @pins = @stream.pins.timeline

    respond_to do |format|
      format.html
      format.json 
    end
  end
end
