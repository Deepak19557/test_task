class RenameColumnFromUser < ActiveRecord::Migration[6.1]
  def change
  	 rename_column :users, :Credit_limit, :credit_limit
  end
end
