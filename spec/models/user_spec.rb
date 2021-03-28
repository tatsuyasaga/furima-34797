require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "新規登録できるとき" do
      it "適切な入力がされれば新規登録できる" do
        expect(@user).to be_valid
      end
    end
    context "新規登録できないとき" do
      it "nicknameが空欄だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "last_nameが空欄だと登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name Full-width characters")
      end
      it "last_name_kanaが空欄だと登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana Full-width katakana characters")
      end
      it "first_nameが空欄だと登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name Full-width characters")
      end
      it "first_name_kanaが空欄だと登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana Full-width katakana characters")
      end
      it "emailが空欄だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空欄だと登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password Include both letters and numbers", "Password confirmation doesn't match Password")
      end
      it "password_confirmationが空欄だと登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "birth_dateが空欄だと登録できない" do
        @user.birth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it "last_nameは全角（漢字・ひらがな・カタカナ）以外で入力すると登録できない" do
        @user.last_name = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
        @user.last_name = "["
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
      end
      it "last_name_kanaは全角（カタカナ）以外で入力すると登録できない" do
        @user.last_name_kana = "あ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
        @user.last_name_kana = "阿"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
        @user.last_name_kana = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
        @user.last_name_kana = "["
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
      end
      it "first_nameは全角（漢字・ひらがな・カタカナ）以外で入力すると登録できない" do
        @user.first_name = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
        @user.first_name = "["
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end
      it "first_name_kanaは全角（カタカナ）以外で入力すると登録できない" do
        @user.first_name_kana = "あ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
        @user.first_name_kana = "阿"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
        @user.first_name_kana = "a"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
        @user.first_name_kana = "["
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
      end
      it "emailは他のユーザーと重複すると登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailは@を含まないと登録できない" do
        @user.email = "a[a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordは6字未満では登録できない" do
        @user.password = "aaa11"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is too short (minimum is 6 characters)")
      end
      it "passwordは6字以上でも半角英字のみでは登録できない" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password Include both letters and numbers")
      end
      it "passwordは6字以上でも数字のみでは登録できない" do
        @user.password = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password Include both letters and numbers")
      end
      it "passwordは6字以上でも全角では登録できない" do
        @user.password = "ａ11111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password Include both letters and numbers")
        @user.password = "aaaaa１"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password Include both letters and numbers")
      end
      it "passwordとpassword_confirmationが一致しないと登録できない" do
        @user.password = "aaa111"
        @user.password_confirmation = "bbb111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
