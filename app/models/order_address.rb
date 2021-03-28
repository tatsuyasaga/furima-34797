class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "input correctly"}
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true, less_than: 100000000000, message: "Input only number" }
    validates :prefecture, numericality: { other_than: 1, message: "Select" }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture, city: city, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end