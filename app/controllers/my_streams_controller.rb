class MyStreamsController < ApplicationController

  def show
    @stream = current_user.streams.find(params[:id]) 
    @item = Item.new

    @pins = @stream.pins.timeline

    respond_to do |format|
      format.html
      format.json 
    end
  end
end
