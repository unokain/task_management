class Task < ApplicationRecord
    validates :details, presence: true
    validates :details, length: { in: 1..100 }
    validates :task_name,  presence: true, length: { maximum: 30 }
    validates :limit, presence: true
end
