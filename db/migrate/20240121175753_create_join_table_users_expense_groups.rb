class CreateJoinTableUsersExpenseGroups < ActiveRecord::Migration[6.1] # rubocop:disable Style/Documentation
  def change
    create_join_table :users, :expense_groups do |t|
      t.index [:user_id, :expense_group_id]
      t.index [:expense_group_id, :user_id]
    end
  end
end
