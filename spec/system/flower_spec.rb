require 'rails_helper'
RSpec.describe '花の投稿管理機能', type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:flower){FactoryBot.create(:flower, user: user)}

  # describe '投稿機能のテスト' do
  #   context '投稿を新規作成した場合' do
  #     it '全て入力したら正常に投稿できること' do
  #       visit new_user_session_path
  #       fill_in 'user_email', with: 'user@example.com'
  #       fill_in 'user_password', with: '12345678'
  #       click_button 'ログイン'
  #       visit new_flower_path
  #       fill_in 'flower_name', with: '桜'
  #       fill_in 'flower_description', with: '可愛い'
  #       fill_in 'flower_address', with: '東京タワー'
  #       execute_script("document.getElementById('lat').value = 35.6895;")
  #       execute_script("document.getElementById('lng').value = 139.6917;")
  #       attach_file 'flower_image', "#{Rails.root}/spec/fixtures/test_image.jpg"
  #       click_button '登録'
  #       expect(page).to have_content '画像を投稿しました'
  #       expect(page).to have_content '桜'
  #     end

  #     it '詳細を入力しなくても正常に投稿できること' do
  #       visit new_user_session_path
  #       fill_in 'user_email', with: 'user@example.com'
  #       fill_in 'user_password', with: '12345678'
  #       click_button 'ログイン'
  #       visit new_flower_path
  #       fill_in 'flower_name', with: '桜'
  #       fill_in 'flower_description', with: ''
  #       fill_in 'flower_address', with: '東京タワー'
  #       execute_script("document.getElementById('lat').value = 35.6895;")
  #       execute_script("document.getElementById('lng').value = 139.6917;")
  #       attach_file 'flower_image', "#{Rails.root}/spec/fixtures/test_image.jpg"
  #       click_button '登録'
  #       expect(page).to have_content '画像を投稿しました'
  #       expect(page).to have_content '桜'
  #     end

  #     it 'バリデーションエラーで投稿できないこと' do
  #       visit new_user_session_path
  #       fill_in 'user_email', with: 'user@example.com'
  #       fill_in 'user_password', with: '12345678'
  #       click_button 'ログイン'
  #       visit new_flower_path
  #       fill_in 'flower_name', with: '桜'
  #       fill_in 'flower_description', with: '可愛い'
  #       fill_in 'flower_address', with: ''
  #       attach_file 'flower_image', "#{Rails.root}/spec/fixtures/test_image.jpg"
  #       click_button '登録'
  #       expect(page).to have_content 'エラーが発生しました'
  #     end
  #   end

  #   context '未ログインの場合' do
  #     it 'ログイン画面に遷移すること' do
  #       visit flowers_path
  #       find('.submit-button').click
  #       expect(page).to have_content 'ログインもしくはアカウント登録してください。'
  #     end
  #   end
  # end

  # describe '編集機能のテスト' do
  #   context '花の名前を編集した場合' do
  #     it '編集した花の名前が表示される' do
  #       visit new_user_session_path
  #       fill_in 'user_email', with: 'user@example.com'
  #       fill_in 'user_password', with: '12345678'
  #       click_button 'ログイン'
  #       visit edit_flower_path(flower)
  #       fill_in 'flower_name', with: 'コスモス'
  #       fill_in 'flower_description', with: '可愛い'
  #       fill_in 'flower_address', with: '東京タワー'
  #       execute_script("document.getElementById('lat').value = 35.6895;")
  #       execute_script("document.getElementById('lng').value = 139.6917;")
  #       attach_file 'flower_image', "#{Rails.root}/spec/fixtures/test_image.jpg"
  #       click_button '登録'
  #       expect(page).to have_content '投稿を編集しました'
  #       expect(page).to have_content 'コスモス'
  #     end
  #   end

  #   context '花の名前を空白にした場合' do
  #     it '編集できない旨が表示される' do
  #       visit new_user_session_path
  #       fill_in 'user_email', with: 'user@example.com'
  #       fill_in 'user_password', with: '12345678'
  #       click_button 'ログイン'
  #       visit edit_flower_path(flower)
  #       fill_in 'flower_name', with: ''
  #       fill_in 'flower_description', with: '可愛い'
  #       fill_in 'flower_address', with: '東京タワー'
  #       execute_script("document.getElementById('lat').value = 35.6895;")
  #       execute_script("document.getElementById('lng').value = 139.6917;")
  #       attach_file 'flower_image', "#{Rails.root}/spec/fixtures/test_image.jpg"
  #       click_button '登録'
  #       expect(page).to have_content '花の名前を入力してください'
  #     end
  #   end
  # end

  # describe '詳細機能のテスト' do
  #   context '花の詳細を確認した場合' do
  #     it '編集した花の名前が表示される' do
  #       visit new_user_session_path
  #       fill_in 'user_email', with: 'user@example.com'
  #       fill_in 'user_password', with: '12345678'
  #       click_button 'ログイン'
  #       click_link '詳細'
  #       sleep(0.5)
  #       expect(page).to have_content '桜'
  #       expect(page).to have_content '東京タワー'
  #     end
  #   end
  # end

  describe '削除機能のテスト' do
    context '花の投稿を削除した場合' do
      it '削除した花の投稿がなくなる' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        accept_confirm do
          click_link '削除'
        end
        sleep(0.5)
        expect(page).not_to have_content '桜'
        expect(page).not_to have_content '東京タワー'
      end
    end
  end
end