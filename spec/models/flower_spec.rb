require 'rails_helper'
RSpec.describe Flower, type: :model do
  let(:user) { User.new(name: 'テストユーザー', email: 'test@example.com', password: 'password', password_confirmation: 'password') }

  describe 'バリデーションのテスト' do
    context 'nameカラム' do
      it 'nameが空の場合、バリデーションにひっかかる' do
        flower = Flower.new(name: '', address: '東京タワー', user: user)
        expect(flower).not_to be_valid
      end

      it 'nameが301文字以上の場合、バリデーションにひっかかる' do
        flower = Flower.new(name: 'a' * 301, address: '東京タワー', user: user)
        expect(flower).not_to be_valid
      end

      it 'nameが300文字以内の場合、バリデーションが通る' do
        flower = Flower.new(name: 'a' * 300, address: '東京タワー', user: user)
        expect(flower).to be_valid
      end
    end

    context 'addresカラム' do
      it 'addressが空の場合、バリデーションにひっかかる' do
        flower = Flower.new(name: '桜', address: '', user: user)
        expect(flower).not_to be_valid
      end

      it 'addressが存在する場合、バリデーションが通る' do
        flower = Flower.new(name: '桜', address: '東京タワー', user: user)
        expect(flower).to be_valid
      end
    end
  end

  describe 'ransackメソッドのテスト' do
    it '検索可能なカラムが正しいこと' do
      expect(Flower.ransackable_attributes).to eq(%w[name description address])
    end

    it '検索可能なモデルが正しいこと' do
      expect(Flower.ransackable_associations).to eq(%w[flower])
    end
  end

end
