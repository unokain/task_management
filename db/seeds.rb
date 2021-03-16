
User.create!(
    email: "test1@test.com",
    name: "テスト太郎1",
    password: "qwertyu#1",
    admin: "true"
    )
User.all.each do |user|
    user.tasks.create!(
      task_name: 'タイトル',
      details: 'テキストテキストテキストテキスト',
      limit: '20220302',
      status: "完了",
      priority: "中"
    )
end