require 'rails_helper'
require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, task_name: 'task',status:"着手") }
    let!(:second_task) { FactoryBot.create(:second_task, task_name: "sample",status:"着手") }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_task_name('task')).to include(task)
        expect(Task.search_task_name('task')).not_to include(second_task)
        expect(Task.search_task_name('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('着手')).to include(task)
        expect(Task.search_status('完了')).not_to include(second_task)
        expect(Task.search_status('着手').count).to eq 2
        # ここに内容を記載する
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_composite('task','着手')).to include(task)
        expect(Task.search_composite('task','完了')).not_to include(second_task)
        expect(Task.search_composite('task','着手').count).to eq 1
      end
    end
  end
end
# describe 'タスクモデル機能', type: :model do
#   describe 'バリデーションのテスト' do
#     context 'タスクのタイトルが空の場合' do
#       it 'バリデーションにひっかる' do
#         task = Task.new(task_name: '', details: '失敗テスト')
#         expect(task).not_to be_valid
#       end
#     end
#     context 'タスクの詳細が空の場合' do
#       it 'バリデーションにひっかかる' do
#         task = Task.new(task_name: '失敗テスト2', details: '')
#         expect(task).not_to be_valid
#         # ここに内容を記載する
#       end
#     end
#     context 'タスクのタイトルと詳細に内容が記載されている場合' do
#       it 'バリデーションが通る' do
#         task = Task.new(task_name: '成功テスト', details: '成功テスト')
#         expect(task).to be_valid
#         # ここに内容を記載する
#       end
#     end
#   end
# end