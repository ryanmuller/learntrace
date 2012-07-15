class UsersController < ApplicationController

  def index
    @pins = Pin.order('updated_at DESC').limit(10)
  end

end
