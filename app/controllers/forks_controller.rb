class ForksController < ApplicationController
  before_filter :authenticate_user!

  def create
    @source = Stream.find(params[:stream_id])
    @target = current_user.streams.find(params[:fork][:target_id])
    @target.fork!(@source)
    redirect_to @target
  end

  def destroy
    @fork = Fork.find(params[:id]).source
    @target = current_user.streams.find(@fork.target)
    @target.dam!(@fork.source)
    redirect_to @target
  end
end
