class TimelineController < ApplicationController
  before_filter :authenticate_user!

  def index
    @stream = Stream.find(params[:stream_id])

    respond_to do |format|
      format.html { render :layout => false }
    end
  end
end
