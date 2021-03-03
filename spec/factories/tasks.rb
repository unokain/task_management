FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    details { 'Factoryで作ったデフォルトのコンテント１' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    details { 'Factoryで作ったデフォルトのコンテント２' }
  end
end