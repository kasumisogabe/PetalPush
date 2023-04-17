require 'rails_helper'
RSpec.describe '投稿機能', type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:flower){FactoryBot.create(:flower, user: user)}

  describe '投稿機能のテスト' do
    context '投稿を新規作成した場合' do
      it '正常に投稿できること' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        visit new_flower_path
        fill_in 'flower_name', with: '桜'
        fill_in 'flower_description', with: '可愛い'
        fill_in 'flower_address', with: '東京タワー'
        execute_script("document.getElementById('lat').value = 35.6895;")
        execute_script("document.getElementById('lng').value = 139.6917;")
        attach_file 'flower_image', "#{Rails.root}/spec/fixtures/test_image.jpg"
        click_button '登録'
        expect(page).to have_content '画像を投稿しました'
      end
    end

    context '投稿を新規作成した場合' do
      it 'バリデーションエラーで投稿できないこと' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        visit new_flower_path
        fill_in 'flower_name', with: '桜'
        fill_in 'flower_description', with: '可愛い'
        fill_in 'flower_address', with: ''
        attach_file 'flower_image', "#{Rails.root}/spec/fixtures/test_image.jpg"
        click_button '登録'
        expect(page).to have_content 'エラーが発生しました'
      end
    end
  end
end