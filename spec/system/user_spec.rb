require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザの新規登録をした場合' do
      it '作成したユーザーページが表示される' do
        visit new_user_path
        fill_in "名前", with: '万葉課題'
        fill_in "メールアドレス", with: 'mcdonal@gmail.com'
        fill_in "パスワード",with: '20211231'
        fill_in "確認用パスワード",with: '20211231'
        click_on 'Create my account'
        expect(page).to have_content 'mcdonal@gmail.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
      it 'タスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content'Log in'
      end
    end
  end
  describe 'セッション機能テスト' do
    before do
        FactoryBot.create(:user, name:"たかし", email: "login@gmail.com", password: '20202020')
        FactoryBot.create(:second_user, name: "sample2")
    end
    context 'ログインできること' do
      it 'ログインしたユーザーのプロフィールが表示される' do
        visit new_session_path
        fill_in "Email", with: 'login@gmail.com'
        fill_in "Password", with: '20202020'
        click_on 'Log in'
        expect(page).to have_content 'login@gmail.com'
      end
    end
    context 'ユーザーページに飛べること' do
      it 'ログインしたユーザーのプロフィールが表示される' do
          visit new_session_path
          fill_in "Email", with: 'login@gmail.com'
          fill_in "Password", with: '20202020'
          click_on 'Log in'
          expect(page).to have_content 'たかし'
          expect(page).not_to have_content 'sample2'
        end
      end
      context '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        it 'ログインしたユーザーのプロフィールが表示される' do
          visit new_session_path
          fill_in "Email", with: 'login@gmail.com'
          fill_in "Password", with: '20202020'
          click_on 'Log in'
          visit "/users/2"
          expect(page).to have_content 'タスク管理ツール'
        end
      end
      context 'ログアウトができること' do
        it 'ログアウトしたフラッシュメッセージを表示' do
          visit new_session_path
          fill_in "Email", with: 'login@gmail.com'
          fill_in "Password", with: '20202020'
          click_on 'Log in'
          click_on 'ログアウト'
          expect(page).to have_content 'ログアウトしました'
        end
      end
  end
  describe '管理画面のテスト' do
    before do
        FactoryBot.create(:user, name:"たかし", email: "login@gmail.com", password: '20202020',admin:"true")
        FactoryBot.create(:second_user, name: "sample2")
        FactoryBot.create(:thrid_user)
    end
    context '管理ユーザは管理画面にアクセスできること' do
      it 'ユーザー管理画面表示' do
        visit new_session_path
        fill_in "Email", with: 'login@gmail.com'
        fill_in "Password", with: '20202020'
        click_on 'Log in'
        click_on 'ユーザー一覧画面'
        expect(page).to have_content 'ユーザ一管理'
      end
    end
    context '一般ユーザは管理画面にアクセスできないこと' do
      it 'タスク一覧画面へリダイレクト' do
        visit new_session_path
        fill_in "Email", with: 'test2@gmail.com'
        fill_in "Password", with: '2222222'
        click_on 'Log in'
        visit "/admin/users"
        expect(page).to have_content 'タスク管理ツール'
      end
    end
    context '管理ユーザはユーザの新規登録ができること' do
      it '新規ユーザー作成のフラッシュを表示' do
        visit new_session_path
        fill_in "Email", with: 'login@gmail.com'
        fill_in "Password", with: '20202020'
        click_on 'Log in'
        click_on 'ユーザー一覧画面'
        click_on 'userを新規作成する'
        fill_in "名前", with:'管理者'
        fill_in "メールアドレス", with:'kanrisya@gmail.com'
        fill_in "パスワード", with:'11111111'
        fill_in "パスワード（確認）", with:'11111111'
        click_on 'Create account'
        expect(page).to have_content 'ユーザ「管理者」を登録しました。'
      end
    end
    context '管理ユーザはユーザの詳細画面にアクセスできること' do
      it '詳細画面表示' do
        visit new_session_path
        fill_in "Email", with: 'login@gmail.com'
        fill_in "Password", with: '20202020'
        click_on 'Log in'
        click_on 'ユーザー一覧画面'
        click_on 'sample2'
        expect(page).to have_content 'sample2のページ'
      end
    end
    context '管理ユーザはユーザの編集画面からユーザを編集できること' do
      it 'ユーザー管理画面に変更した名前が記載されている' do
        visit new_session_path
        fill_in "Email", with: 'login@gmail.com'
        fill_in "Password", with: '20202020'
        click_on 'Log in'
        click_on 'ユーザー一覧画面'
        click_on 'sample2'
        click_on 'userを編集する'
        fill_in '名前',with:'サンプル３'
        fill_in "確認用パスワード", with: '20202021'
        fill_in "パスワード", with: '20202021'
        click_on 'Create User'
        expect(page).to have_content 'サンプル３'
        expect(page).to have_content 'ユーザ一管理'
      end
    end
    context '管理ユーザはユーザの削除をできること' do
      it 'ユーザー管理画面に削除した名前が表示されていない' do
        visit new_session_path
        fill_in "Email", with: 'login@gmail.com'
        fill_in "Password", with: '20202020'
        click_on 'Log in'
        click_on 'ユーザー一覧画面'
        click_on 'sample2'
        click_on 'userを削除する'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザ「sample2」を削除しました。'
        expect(page).to have_content 'ユーザ一管理'
      end
    end

  end
end
#rspec spec/system/user_spec.rb