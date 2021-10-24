class AddColumnCreditLimitToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :Credit_limit, :string
  end
end
