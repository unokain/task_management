require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "Task name", with: '万葉課題'
        fill_in "Details", with: '課題の進捗状況'
        click_on 'Create Task'
        expect(page).to have_content '課題の進捗状況'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, task_name: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）git
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        Task.create(id: 1, task_name: 'hi', details: 'hi')
        Task.create(id: 2, task_name: 'hi', details: 'hihi2', created_at: Time.current + 1.days)
        Task.create(id: 3, task_name: 'hiii', details: 'hihi3', created_at: Time.current + 2.days)
        Task.create(id: 4, task_name: 'hiiiii', details: 'hihi4', created_at: Time.current + 3.days)
        visit tasks_path
        task = all('#task_list')
        task_0 = task[0]
        expect(task_0).to have_content '4'
        save_and_open_page
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, task_name: '万葉課題')
        visit task_path(task)
        expect(page).to have_content '万葉課題'
       end
     end
  end
end