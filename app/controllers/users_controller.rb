class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @pins = @user.pins
    
    respond_to do |format|
      format.html
      format.json { render 'pins/library_items' }
    end
  end
end
