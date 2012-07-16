class PathsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @paths = current_user.paths
  end

end
