FactoryBot.define do
  factory :label do
    title { "ruby" }
  end
  factory :second_label, class: Label do
    title { "PHP" }
  end
  factory :therd_label, class: Label do
    title { "css" }
  end
end
