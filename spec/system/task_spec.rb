require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "Task name", with: '万葉課題'
        fill_in "Details", with: '課題の進捗状況'
        fill_in "Limit",with: '20211231'
        find("option[value='完了']").select_option
        find("option[value='高']").select_option
        click_on 'Create Task'
        expect(page).to have_content '課題の進捗状況'
      end
    end
    describe '検索機能' do
      before do
        # 必要に応じて、テストデータの内容を変更して構わない
        FactoryBot.create(:task, task_name: "task1",status:"未着手")
        FactoryBot.create(:second_task, task_name: "sample2",status:"完了")
        FactoryBot.create(:third_task, task_name: "mofmof課題",status:"完了")
      end
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          fill_in "keyword", with: 'mofmof課題'
          click_on '検索'
          # タスクの検索欄に検索ワードを入力する (例: task)
          # 検索ボタンを押す
          expect(page).to have_content 'mofmof課題'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          find("option[value='完了']").select_option
          click_on '検索'
          lists = all('#task_status')
          lists.each do |li|
            expect(page).to have_content '完了'
          end
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          fill_in "keyword", with: 'mofmof課題'
          find("option[value='完了']").select_option
          click_on '検索'
          lists = all('#task_status')
          expect(page).to have_content '完了'
          expect(page).to have_content 'mofmof課題'
          # ここに実装する
        end
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
        #変更があるたび、要素を追加する必要があり、大変なので、で切るだけfactorybotを使おう
        Task.create(id: 1, task_name: 'hi', details: 'hi',limit: '20210301',status:"完了",priority:"中")
        Task.create(id: 2, task_name: 'hi', details: 'hihi2',limit: '20210401',status:"未着手", priority:"中",created_at: Time.current + 1.days)
        Task.create(id: 3, task_name: 'hiii', details: 'hihi3', limit: '20210501',status:"着手", priority:"中",created_at: Time.current + 2.days)
        Task.create(id: 4, task_name: 'hiiiii', details: 'hihi4',limit: '20210601', status:"着手", priority:"中",created_at: Time.current + 3.days)
        visit tasks_path
        task = all('#task_list')
        task_0 = task[0]
        expect(task_0).to have_content '4'
        save_and_open_page
      end
    end
    context 'タスクの終了期限を降順で並べ替える場合' do
      it '終了期限が新しいタスクが一番上に表示される' do
        Task.create(id: 1, task_name: 'ahi', details: 'ahi', limit: '20210301',status:"完了",priority:"中")
        Task.create(id: 2, task_name: 'ahii', details: 'ahihi2',limit: '20210401',status:"完了", priority:"中",created_at: Time.current + 1.days)
        Task.create(id: 3, task_name: 'ahiii', details: 'ahihi3',limit: '20210501', status:"完了",priority:"中",created_at: Time.current + 2.days)
        Task.create(id: 4, task_name: 'ahiiiii', details: 'ahihi4',limit: '20210601', status:"完了",priority:"中",created_at: Time.current + 3.days)
        visit tasks_path
        click_on "終了期限"
        task = all('#task_limit')
        task_0 = task[0]
        expect(task_0).to have_content '2021/06/01'
        save_and_open_page
      end
    end
    context 'タスクの優先順位を昇順で並べ替える場合' do
      it '優先順位高が一番上に表示される' do
        Task.create(id: 1, task_name: 'bhi', details: 'bhi', limit: '20210301',status:"完了",priority:"中")
        Task.create(id: 2, task_name: 'bhii', details: 'bhihi2',limit: '20210401',status:"完了", priority:"中",created_at: Time.current + 1.days)
        Task.create(id: 3, task_name: 'bhiii', details: 'bhihi3',limit: '20210501', status:"完了",priority:"中",created_at: Time.current + 2.days)
        Task.create(id: 4, task_name: 'bhiiiii', details: 'bhihi4',limit: '20210601', status:"完了",priority:"高",created_at: Time.current + 3.days)
        visit tasks_path
        click_on "優先度"
        task = all('#task_priority')
        task_0 = task[0]
        expect(task_0).to have_content '高'
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