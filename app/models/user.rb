# user model
class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  has_many :friendships
  has_many :friends, through: :friendships

  has_and_belongs_to_many :expense_group

  has_many :expenses
end
