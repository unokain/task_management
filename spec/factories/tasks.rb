FactoryBot.define do
  factory :task do
    task_name { 'Factoryで作ったデフォルトのタイトル１' }
    details { 'Factoryで作ったデフォルトのコンテント１' }
    limit {'20210201'}
    status {"完了"} 
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル２' }
    details { 'Factoryで作ったデフォルトのコンテント２' }
    limit {'20220302'}
    status {"完了"}
  end
  factory :third_task, class: Task do
    task_name { 'Factoryで作ったデフォルトのタイトル3' }
    details { 'Factoryで作ったデフォルトのコンテント3' }
    limit {'20220403'}
    status {"完了"}
  end
end
