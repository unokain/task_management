#herokuへのデプロイ手順
  1.heroku create
  2.heroku stack:set heroku-18
  3.git push heroku master 
  4.heroku run rails db:migrate  
  
  
  #データベース構成
1.task.rb
  2. task_name : string
  3. details        : text

1.user.rb
  2. name : string
  3.email : string
  4.password : string

1.label.rb





