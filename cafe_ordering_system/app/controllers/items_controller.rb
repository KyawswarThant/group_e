class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    @is_item_create = ItemService.create_item(@item)
    logged_in_chef = Chef.find_by(id: session[:chef_id])

    if @is_item_create
      ItemMailer.with(item: @item, logged_in_chef: logged_in_chef).send_mail.deliver_now
      redirect_to items_path
    else
      flash[:errors] = @item.errors.full_messages
      render :new
    end
    
  end

  def show
    @item = ItemService.get_item_by_id(params[:id])
  end

  def edit
    @item = ItemService.get_item_by_id(params[:id])
  end

  def update
    @item = ItemService.get_item_by_id(params[:id])
    @item.update(item_params)
    redirect_to(item_path(@item))
  end

  def destroy
    @item = ItemService.get_item_by_id(params[:id])
    @item = ItemService.delete_item
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :category, :name, :price )
  end
end
