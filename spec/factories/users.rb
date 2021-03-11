FactoryBot.define do
  factory :user do
      name { 'test1' }
      email { 'test1@gmail.com' }
      password {'1111111'}
      admin {"false"}
  end
  factory :second_user, class: User do
    name { 'test2' }
    email { 'test2@gmail.com' }
    password {'2222222'}
    admin {"false"}
  end
  factory :thrid_user, class: User do
    name { 'admin' }
    email { 'admin@gmail.com' }
    password {'aaaaaaa'}
    admin {"false"}
  end
end
