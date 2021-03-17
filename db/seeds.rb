10.times do |i|
User.create!(
    email: "test#{i + 1}@test.com",
    name: "テスト太郎1#{i + 1}",
    password: "qwertyu#{i + 1}",
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
end
10.times do |i|
  Label.create!(title: "sample#{i + 1}")
end