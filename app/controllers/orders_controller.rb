class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def index
    @order_address = OrderAddress.new
    if @item.order.present?
      redirect_to root_path
    end
  end
  

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def correct_user
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.order.present?
    redirect_to root_path
    end
  end

  def order_params
   params.require(:order_address).permit(:postal_code, :prefecture, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id,token: params[:token],item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: "jpy"
    )
  end
end
