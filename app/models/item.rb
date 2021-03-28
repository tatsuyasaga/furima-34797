class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :price
    validates :description
    validates :image
  end

  with_options  numericality: { other_than: 1, message: "Select" } do
    validates :category_id
    validates :items_condition_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :shipping_date_id
  end

  validates :price, numericality: { only_integer: true, message: "Half-width number"}
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range"}

  belongs_to :user
  has_one :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :items_condition
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :shipping_date

  has_one_attached :image
end
