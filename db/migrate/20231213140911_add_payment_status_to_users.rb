class AddPaymentStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :payment_status, :string, default: 'not_paid'
  end
end
