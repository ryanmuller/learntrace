class StreamPinsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @stream = current_user.streams.find(params[:stream_id])
    @item = Item.create!(params[:item])
    current_user.pin_and_copy!(@item, @stream)

    respond_to do |format|
      format.js
    end
  end
end
