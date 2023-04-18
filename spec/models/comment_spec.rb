require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'テスト', email: 'test@example.com', password: 'password', password_confirmation: 'password') }
  let(:flower) { Flower.new(name: '桜', address: '東京タワー', user: user) }

  describe 'バリデーションのテスト' do
    context 'contentモデル' do
      it 'contentが存在する場合、バリデーションが通る' do
        comment = Comment.new(content: 'これはテストコメントです。', flower: flower, user: user)
        expect(comment).to be_valid
      end

      it 'contentが空の場合、バリデーションにひっかかる' do
        comment = Comment.new(content: '', flower: flower, user: user)
        expect(comment).not_to be_valid
      end

      it 'contentが300文字以内の場合、バリデーションが通る' do
        content = 'a' * 300
        comment = Comment.new(content: content, flower: flower, user: user)
        expect(comment).to be_valid
      end

      it 'contentが301文字以上の場合、バリデーションにひっかかる' do
        content = 'a' * 301
        comment = Comment.new(content: content, flower: flower, user: user)
        expect(comment).not_to be_valid
      end
    end
  end
end