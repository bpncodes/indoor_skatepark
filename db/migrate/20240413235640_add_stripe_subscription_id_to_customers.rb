class AddStripeSubscriptionIdToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :stripe_subscription_id, :string
  end
end
