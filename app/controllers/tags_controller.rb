class TagsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @tag = Tag.find_by_name(params[:tag][:name]) || Tag.create(params[:tag])
    if Tagging.where("user_id = ? AND tag_id = ? AND item_id = ?", current_user.id, @tag.id, @item.id).count > 0
      redirect_to @item, :notice => 'Could not add tag.'
    else 
      @item.tags.push_with_attributes(@tag, :user => current_user)
      redirect_to @item, :notice => 'Tag created successfully.' 
    end
  end

  def show
    @tag = Tag.find_by_name(params[:name], :include => :items)
    @items = @tag.items.best

    division = (@items.count / 3).to_i

    @col_array = [@items[0..division], @items[division+1..2*division], @items[2*division+1..-1]]
  end
end
