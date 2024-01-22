class CreateExpenses < ActiveRecord::Migration[6.1] # rubocop:disable Style/Documentation
  def change
    create_table :expenses do |t|
      t.string :description
      t.decimal :amount
      t.references :user, null: false, foreign_key: true
      t.references :expense_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
