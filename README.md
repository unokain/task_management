task.rb
• task_name : string
• details        : text

user.rb
• name : string
• email : string
• password : string

label.rb


herokuへのデプロイ手順
  1.heroku create
  2.heroku stack:set heroku-18
  3.git push heroku master
  4.heroku run rails db:migrate  
