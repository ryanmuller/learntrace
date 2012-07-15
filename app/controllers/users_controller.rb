class UsersController < ApplicationController

  def index
    @pins = Pin.limit(10)
  end

end
