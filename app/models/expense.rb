# expense model
class Expense < ApplicationRecord
  validates :description, presence: true
  validates :amount, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :expense_group
end
