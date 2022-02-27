require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'すべての項目が正しく入力されていれば新規登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録ができない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailを入力しても登録できない' do
        another_user = FactoryBot.create(:user)
        @user.email = another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = "testtest"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordは全角入力では登録できない' do
        @user.password = "１２３４５６７"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input both half-width characters and numbers.")
      end
      it 'passwordは半角数字だけでは登録できない' do
        @user.password = "123456"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input both half-width characters and numbers.")
      end
      it 'passwordは半角英字だけでは登録できない' do
        @user.password = "TESTtest"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Input both half-width characters and numbers.")
      end
      it 'passwordは6文字以上でないと登録できない' do
        @user.password = "123ab"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = "abcd1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '苗字が空では登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '苗字が半角入力では登録できない' do
        @user.last_name = "Test"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters.")
      end
      it '名前が空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名前が半角入力では登録できない' do
        @user.first_name = "Test"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters.")
      end
      it 'カナ苗字が空では登録できない' do
        @user.last_name_reading = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading can't be blank")
      end
      it 'カナ苗字が半角入力では登録できない' do
        @user.last_name_reading = "Test"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading is invalid. Input full-width katakana characters.")
      end
      it 'カナ苗字にひらがなが入っていると登録できない' do
        @user.last_name_reading = "やまだ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading is invalid. Input full-width katakana characters.")
      end
      it 'カナ苗字に漢字が入っていると登録できない' do
        @user.last_name_reading = "山田"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading is invalid. Input full-width katakana characters.")
      end
      it 'カナ名が空では登録できない' do
        @user.first_name_reading = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading can't be blank")
      end
      it 'カナ名が半角入力では登録できない' do
        @user.first_name_reading = "Test"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading is invalid. Input full-width katakana characters.")
      end
      it 'カナ名にひらがなが入っていると登録できない' do
        @user.first_name_reading = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name reading is invalid. Input full-width katakana characters.")
      end
      it 'カナ苗字に漢字が入っていると登録できない' do
        @user.last_name_reading = "太郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name reading is invalid. Input full-width katakana characters.")
      end
      it '誕生日が空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
