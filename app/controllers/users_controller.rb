class UsersController < ApplicationController
  def show
    if params[:username]
      @user = User.find_by_username(params[:username])
      unless @user
        render :template => 'users/404' unless @user
        return
      end
    else
      @user = User.find(params[:id])
    end
    @pins = @user.pins
    
    respond_to do |format|
      format.html
      format.json { render 'pins/library_items' }
    end
  end
end
