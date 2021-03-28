require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品を出品" do
    context "出品できるとき" do
      it "適切に情報を入力すれば出品できる" do
        expect(@item).to be_valid
      end
      it "priceが300円だと出品できる" do
        @item.price = 300
        expect(@item).to be_valid
      end
      it "priceが9999999円だと出品できる" do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end
    context "出品できないとき" do
      it "画像が空欄だと出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "商品名が空欄だと出品できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "priceが空欄だと出品できない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "descriptionが空欄だと出品できない" do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it "category_idが空欄だと出品できない" do
        @item.category_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select")
      end
      it "category_idが1だと出品できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select")
      end
      it "items_condition_idが空欄だと出品できない" do
        @item.items_condition_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Items condition Select")
      end
      it "items_condition_idが1だと出品できない" do
        @item.items_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Items condition Select")
      end      
      it "delivery_feeが空欄だと出品できない" do
        @item.delivery_fee_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee Select")
      end
      it "delivery_feeが1だと出品できない" do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee Select")
      end      
      it "prefectureが空欄だと出品できない" do
        @item.prefecture_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture Select")
      end
      it "prefectureが1だと出品できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture Select")
      end      
      it "shipping_dateが空欄だと出品できない" do
        @item.shipping_date_id = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date Select")
      end
      it "shipping_dateが1だと出品できない" do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date Select")
      end      
      it "userと紐づいてないと出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      it "priceが半角数字以外だと出品できない" do
        @item.price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number", "Price Out of setting range")
      end
      it "priceが300円未満だと出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
      it "priceが10000000円以上だと出品できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end
      it "priceが半角英数混合だと出品できない" do
        @item.price = "aaa111"
        @item.valid?
        binding.pry
        expect(@item.errors.full_messages).to include("Price Half-width number", "Price Out of setting range")
      end
      it "priceが半角英語のみだと出品できない" do
        @item.price = "aaa"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width number", "Price Out of setting range")
      end
    end
  end
end

