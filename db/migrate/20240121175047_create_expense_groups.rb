class CreateExpenseGroups < ActiveRecord::Migration[6.1] # rubocop:disable Style/Documentation
  def change
    create_table :expense_groups do |t|
      t.string :name
      t.string :created_by

      t.timestamps
    end
  end
end
