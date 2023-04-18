require 'rails_helper'

RSpec.describe 'お気に入り管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:flower) { FactoryBot.create(:flower, user: user) }
  let!(:second_flower) { FactoryBot.create(:second_flower, user: user) }

  describe 'お気に入り追加機能のテスト' do
    context 'お気に入りに追加した場合' do
      it 'お気に入りに追加されること' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        click_link '詳細', match: :first
        sleep(0.5)
        click_link 'お気に入りする'
        expect(page).to have_content 'お気に入りを解除する'
        expect(page).to have_content 'ひまわり'
      end
    end

    context 'お気に入りを削除した場合' do
      it 'お気に入りが削除されること' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        click_link '詳細', match: :first
        sleep(0.5)
        click_link 'お気に入りする'
        click_link 'プロフィール'
        click_link 'お気に入り一覧'
        click_link '詳細', match: :first
        sleep(0.5)
        click_link 'お気に入りを解除する'
        expect(page).to have_content '花の詳細情報'
        expect(page).to have_content 'お気に入りする'
      end
    end
  end

  describe 'お気に入り一覧機能のテスト' do
    context 'お気に入りした場合' do
      it 'お気に入り一覧に表示されること' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        click_link '詳細', match: :first
        sleep(0.5)
        click_link 'お気に入りする'
        click_link 'プロフィール'
        click_link 'お気に入り一覧'
        expect(page).to have_content '花のお気に入り一覧'
        expect(page).to have_content 'ひまわり'
      end
    end
  end
end