class Label < ApplicationRecord
    has_many :task_labels, dependent: :destroy, foreign_key: 'label_id'
    has_many :tasks, through: :task_labels, source: :task
    validates :title, presence: true
    validates :title, length: { in: 1..20 }
end
