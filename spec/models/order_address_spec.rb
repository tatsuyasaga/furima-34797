require "rails_helper"

RSpec.describe OrderAddress, type: :model do
  describe "購入記録の保存" do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context "保存できる場合" do
      it "全ての値が正しく入力されていれば保存できる" do
        expect(@order_address).to be_valid
      end

      it "建物名は空欄でも保存できる" do
        @order_address.building_name = ""
        expect(@order_address).to be_valid
      end
    end

    context "保存できない場合" do
      it "郵便番号が空欄だと保存できない" do
        @order_address.postal_code = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank", "Postal code input correctly")
      end

      it "都道府県を選択しないと保存できない" do
        @order_address.prefecture = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture Select")
      end

      it "市区町村が空だと保存できない" do
        @order_address.city = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it "番地が空だと保存できない" do
        @order_address.address = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end

      it "電話番号が空だと保存できない" do
        @order_address.phone_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", "Phone number Input only number")
      end

      it "トークンがないと保存できない" do
        @order_address.token = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it "user_idがないと保存できない" do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it "item_idがないと保存できない" do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it "郵便番号は半角でないと保存できない" do
        @order_address.postal_code = "１１１-１１１１"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code input correctly")
      end

      it "郵便番号はハイフンがないと保存できない" do
        @order_address.postal_code = "1111111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code input correctly")
      end

      it "電話番号は全角では保存できない" do
        @order_address.phone_number = "１１１１１１１１１１１"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number Input only number")
      end

      it "電話番号は11桁を超えると保存できない" do
        @order_address.phone_number = "111111111111"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number Input only number")
      end

      it "電話番号に数字以外の文字があると保存できない" do
        @order_address.phone_number = "1111111111あ"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number Input only number")
      end
    end
  end
end