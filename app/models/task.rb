class Task < ApplicationRecord
    validates :details, presence: true
    validates :details, length: { in: 1..100 }
    validates :task_name,  presence: true, length: { maximum: 30 }
    validates :limit, presence: true
    validates :status, presence: true
    default_scope -> { order(created_at: :desc) }
    scope :search_task_name, ->(n){where('task_name LIKE(?)', "%#{n}%")}
    scope :search_status, ->(i){where('status =(?)', "#{i}")}
    scope :search_composite, ->(n,i){where('task_name LIKE(?)', "%#{n}%").merge(Task.where('status =(?)', "#{i}"))}
    scope :limit_sort, -> { order(limit: :desc) }
end
