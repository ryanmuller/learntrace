class PathsController < ApplicationController

  def index
    @paths = current_user.paths
  end

end
