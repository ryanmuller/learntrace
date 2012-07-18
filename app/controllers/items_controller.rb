class ItemsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index, :show, :tag_filter ]

  def index
    @tags = Tag.order("RANDOM()").limit(12)
    @tag_data = Tag.all.map{|t| t.name }.join(",")

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :layout => false }
    end
  end

  def new 
    @item = Item.new({ :url => params[:url], :description => params[:description], :name => params[:name] })

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  def tag_filter
    # user has cleared tag search; render main objects
    if params[:tag].empty?
      @tags = Tag.order("RANDOM()").limit(12)
      render :partial => 'item_board', :layout => false
      return false
    else
      @tag = Tag.find_by_name(params[:tag], :include => :items)
      @items = @tag.items.best
      division = (@items.count / 3).to_i
      @col_array = [@items[0..division], @items[division+1..2*division], @items[2*division+1..-1]]
    end

    respond_to do |format|
      format.js { render :layout => false }
    end

  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        current_user.pin!(@item)
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
