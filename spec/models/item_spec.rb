require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品出品機能" do
    context '商品を出品できるとき' do
      it 'すべての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品を出品できないとき' do
      it '画像が添付されていない場合は出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空なら出品できない' do
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品説明が空なら出品できない' do
        @item.info = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'カテゴリーが選択されていないなら出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態が選択されていないなら出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担が選択されていないなら出品できない' do
        @item.delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery can't be blank")
      end
      it '発送元の地域が選択されていないなら出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数が選択されていないなら出品できない' do
        @item.send_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Send day can't be blank")
      end
      it '価格が空なら出品できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が全角漢字入力なら出品できない' do
        @item.price = "商品価格"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it '価格が全角ひらがな入力なら出品できない' do
        @item.price = "しょうひんかかく"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it '価格が全角カタカナ入力なら出品できない' do
        @item.price = "ショウヒンカカク"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it '価格が半角英字入力なら出品できない' do
        @item.price = "price"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it '価格が300円より安いときは出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it '価格が9999999円より高いときは出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it 'ユーザーが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
