require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入機能' do
    context '商品が購入できるとき' do
      it 'すべての項目が正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
      it '建物の名前が空でも購入できる' do
        @order_address.building_name = ""
        expect(@order_address).to be_valid
      end
    end
    context '商品が購入できないとき' do
      it '郵便番号が空なら購入できない' do
        @order_address.postal_code = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号にハイフンが入っていないと購入できない' do
        @order_address.postal_code = "1112222"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号に漢字が入っていると購入できない' do
        @order_address.postal_code = "111-郵便番号"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号にひらがなが入っていると購入できない' do
        @order_address.postal_code = "111-ひらがな"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号にカタカナが入っていると購入できない' do
        @order_address.postal_code = "111-郵便番号"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号に半角英字が入っていると購入できない' do
        @order_address.postal_code = "111-abcd"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県が空なら購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空なら購入できない' do
        @order_address.city = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空なら購入できない' do
        @order_address.house_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it '電話番号が空なら購入できない' do
        @order_address.phone_number = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が少数なら購入できない' do
        @order_address.phone_number = "200045.3675"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number must be an integer")
      end
      it '電話番号に漢字が入っていると購入できない' do
        @order_address.phone_number = "漢字漢字漢字漢字漢字"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is not a number")
      end
      it '電話番号にひらがなが入っていると購入できない' do
        @order_address.phone_number = "でんわばんごうでんわ"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is not a number")
      end
      it '電話番号にカタカナが入ってると購入できない' do
        @order_address.phone_number = "デンワバンゴウデンワ"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is not a number")
      end
      it '電話番号に半角英字が入っていると購入できない' do
        @order_address.phone_number = "abcdefghij"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is not a number")
      end
      it '電話番号が9文字以下なら購入できない' do
        @order_address.phone_number = "123456789"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it '電話番号が12文字以上なら購入できない' do
        @order_address.phone_number = "012345678910"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it 'トークンが空なら購入できない' do
        @order_address.token = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'ユーザーが紐付いていないと購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it '商品が紐付いていないと購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
