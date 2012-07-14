class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @comment = Comment.create(:item_id => @item.id, :user_id => current_user.id, :content => params[:comment][:content])
    redirect_to @item
  end
end
