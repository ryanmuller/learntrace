class ItemsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :index, :show, :tag_filter ]

  def index
    @col_array = [[],[],[]] # 3 col layout
    @tags = Tag.order("RANDOM()").limit(12)


    @tags.each_with_index do |tag, index|
      @col_array[index % 3] << tag
    end

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
    @col_array = [[],[],[]] # 3 col layout
    if params[:tag].empty?
      @clear_board = true
      @tags = Tag.order("RANDOM()").limit(12)
      @tags.each_with_index do |tag, index|
        @col_array[index % 3] << tag
      end
      render 'index.js.erb', :layout => false, :format => :js
      return 
    else
      @tag = Tag.find_by_name(params[:tag], :include => :items)
      if @tag.nil?
        # do something more intelligent here...?
        redirect_to items_path
        return 
      end
      @items = @tag.items.best
      @items.each_with_index do |item, index|
        @col_array[index % 3] << item
      end
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
