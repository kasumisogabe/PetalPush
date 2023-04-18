require 'rails_helper'
RSpec.describe 'Userモデル機能', type: :model do
  # describe 'バリデーションのテスト' do
  #   context '名前が空の場合' do
  #     it 'バリデーションにひっかかる' do
  #       user = User.new(name: '')
  #       expect(user).not_to be_valid
  #     end
  #   end
  
  #   context '名前が301文字以上の場合' do
  #     it 'バリデーションにひっかかる' do
  #       user = User.new(name: 'a' * 301)
  #       expect(user).not_to be_valid
  #     end
  #   end
  
  #   context 'メールアドレスが空の場合' do
  #     it 'バリデーションにひっかかる' do
  #       user = User.new(email: '')
  #       expect(user).not_to be_valid
  #     end
  #   end
  
  #   context 'メールアドレスが301文字以上の場合' do
  #     it 'バリデーションにひっかかる' do
  #       user = User.new(email: 'a' * 244 + '@example.com')
  #       expect(user).not_to be_valid
  #     end
  #   end
  
  #   context 'パスワードが5文字以下の場合' do
  #     it 'バリデーションにひっかかる' do
  #       user = User.new(password: '12345', password_confirmation: '12345')
  #       expect(user).not_to be_valid
  #     end
  #   end
  
  #   context 'パスワードが301文字以上の場合' do
  #     it 'バリデーションにひっかかる' do
  #       user = User.new(password: 'a' * 301, password_confirmation: 'a' * 301)
  #       expect(user).not_to be_valid
  #     end
  #   end
  # end

  describe 'ゲストユーザーのテスト' do
    context '一般のゲストユーザーを作成する場合' do
      it 'ゲストユーザーが正しく作成されること' do
        guest = User.guest
        expect(guest.email).to eq 'guest@example.com'
        expect(guest.name).to eq 'ゲスト'
        expect(guest).to be_persisted
      end
    end
  
    context '管理者のゲストユーザーを作成する場合' do
      it 'ゲスト管理者ユーザーが正しく作成されること' do
        guest_admin = User.guest_admin
        expect(guest_admin.email).to eq 'guest_admin@example.com'
        expect(guest_admin.name).to eq 'ゲスト管理者'
        expect(guest_admin.admin).to be true
        expect(guest_admin).to be_persisted
      end
    end
  end
end