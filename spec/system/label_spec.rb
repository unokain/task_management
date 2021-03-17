require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
   before do
     @user=FactoryBot.create(:user)
     @task=FactoryBot.create(:task,user: @user)
     FactoryBot.create(:label)
     FactoryBot.create(:second_label)
     FactoryBot.create(:therd_label)

  end
  describe 'ラベル新規作成機能' do
    context 'ラベルを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_session_path
        fill_in "Email", with: 'login1@gmail.com'
        fill_in "Password", with: '20202020'
        click_on 'Log in'
        visit new_label_path
        fill_in "Title", with: 'java'
        click_on 'Create Label'
        expect(page).to have_content 'java'
      end
    end
  end
    describe '検索機能' do
      context 'ラベル名で検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit new_session_path
          fill_in "Email", with: 'login1@gmail.com'
          fill_in "Password", with: '20202020'
          click_on 'Log in'
          visit tasks_path
          select "ruby",from:"label_id"
          click_on 'Search'
          lists = all('#task_label')
          lists.each do |li|
            expect(li).to have_content 'ruby'               
          end
        end
     end
  end
  describe '一覧表示機能' do
    context 'ラベルの一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit new_session_path
        fill_in "Email", with: 'login1@gmail.com'
        fill_in "Password", with: '20202020'
        click_on 'Log in'
        visit labels_path
        expect(page).to have_content 'Labels'
      end
    end
  end
end