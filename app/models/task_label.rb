class TaskLabel < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :label, optional: true
end
