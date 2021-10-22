class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :user_pan_card
      t.integer :user_adhar_number
      t.integer :bank_account_number
      t.string  :bank_account_ifsc
      t.string  :money_inflow_in_account
      t.string  :money_outflow_in_account
 
      t.timestamps
    end
  end
end
