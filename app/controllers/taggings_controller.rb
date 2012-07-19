class TaggingsController < ApplicationController

  before_filter :authenticate_user!

  def destroy
    @tagging = Tagging.find(params[:id])
    if @tagging.user != current_user
      render  :text => "You don't own that tag!" 
      return
    else
      @tagging.destroy
    end

    respond_to do |format|
      format.js
    end
  end
end
