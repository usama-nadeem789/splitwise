# expense_group model
class ExpenseGroup < ApplicationRecord
  validates :name, presence: true
  validates :user_id, presence: true

  has_and_belongs_to_many :users
  has_many :expenses
end
