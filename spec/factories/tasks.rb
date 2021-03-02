FactoryBot.define do
    factory :task do
      # 下記の内容は実際に作成するカラム名に合わせて変更してください
      task_name { 'test_task_name' }
      details { 'test_details' }
    end
    factory :second_task, class: Task do
      task_name { 'Factoryで作ったデフォルトのタイトル２' }
      details { 'Factoryで作ったデフォルトのコンテント２' }
    end
  end