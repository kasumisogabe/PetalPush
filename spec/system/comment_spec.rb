require 'rails_helper'

RSpec.describe 'コメント機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:flower) { FactoryBot.create(:flower, user: user) }
  let!(:comment) { FactoryBot.create(:comment, flower: flower, user: user) }

  describe 'コメント投稿のテスト' do
    context 'コメントを投稿する場合' do
      it '投稿されたコメントが表示される' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        click_link '詳細'
        sleep(0.5)
        fill_in 'comment_content', with: '可愛い花ですね'
        click_button '登録する'
        sleep(1)
        expect(page).to have_content '可愛い花ですね'
      end
    end

    context 'コメントを編集する場合' do
      it '編集されたコメントが表示される' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        click_link '詳細'
        sleep(0.5)
        find('.comment-actions a', text: 'コメントを編集').click
        sleep(0.5)
        find("[data-test-id='test_comment_content']").set('これは新しいコメントです。')
        sleep(0.5)
        click_button '更新する'
        sleep(1)
        expect(page).to have_content 'これは新しいコメントです。'
      end
    end

    context 'コメントを削除する場合' do
      it '削除されたコメントがなくなる' do
        visit new_user_session_path
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: '12345678'
        click_button 'ログイン'
        click_link '詳細'
        sleep(0.5)
        find('.comment-actions .custom-link', text: 'コメントを削除', match: :first).click
        page.driver.browser.switch_to.alert.accept
        sleep(0.5)
        expect(page).not_to have_content 'これはコメントです。'
      end
    end
  end
end