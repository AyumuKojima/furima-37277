class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :get_item, only: [:edit, :update, :show]
  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    if current_user.id != @item.user_id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :info, :category_id, :condition_id, :delivery_id, :prefecture_id, :send_day_id, :price).merge(user_id: current_user.id)
  end

  def get_item
    @item = Item.find(params[:id])
  end
end
