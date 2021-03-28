class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :item_params_id, only: [:show, :edit, :update, :destroy]
  before_action :seller, only: [:edit, :update, :destroy]
  before_action :item_present, only: [:edit, :update, :destroy]

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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end    
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :category_id, :items_condition_id, :delivery_fee_id, :prefecture_id, :shipping_date_id, :image).merge(user_id: current_user.id)
  end

  def item_params_id
    @item = Item.find(params[:id])
  end

  def seller
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def item_present
    if @item.order.present?
      redirect_to root_path
    end
  end
end
