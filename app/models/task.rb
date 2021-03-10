class Task < ApplicationRecord
    validates :details, presence: true
    validates :details, length: { in: 1..100 }
    validates :task_name,  presence: true, length: { maximum: 30 }
    validates :limit, presence: true
    validates :status, presence: true
    validates :priority, presence: true
    #default_scope -> {  }
    scope :search_task_name, ->(n){where('task_name LIKE(?)', "%#{n}%")}
    scope :search_status, ->(i){where('status =(?)', "#{i}")}
    scope :search_composite, ->(n,i){where('task_name LIKE(?)', "%#{n}%").merge(Task.where('status =(?)', "#{i}"))}
    scope :limit_sort, -> { order(limit: :desc) }
    enum priority: { "高" => 0, "中" => 1, "低" => 2 }
    scope :priority_sort, -> { order(priority: :asc) }
end
