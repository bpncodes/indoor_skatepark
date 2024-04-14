# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class Customer < ApplicationRecord
  after_create :create_stripe_customer

  def subscribe_to_plan(plan_id)
    begin
      plan = Stripe::Plan.retrieve(plan_id)
      subscription = Stripe::Subscription.create(
        customer: stripe_customer_id,
        items: [{ plan: plan_id }],
	default_payment_method: Stripe::PaymentMethod.list({customer: stripe_customer_id}).first.id,
      )

      update(stripe_subscription_id: subscription.id)
      true
    rescue Stripe::StripeError => e
      # Handle the error
      Rails.logger.error("Stripe Error: #{e.message}")
      false
    end
  end

  def create_stripe_customer
    begin
      Stripe.api_key = 'sk_test_51P4zQ7RuKjTLXSCQpVSgedTveUu06TBhdBwg78oDFBEgehLlFWoUXrEMw4WggyNAoTLaSdcKCEc12daYWwQcIsRC00iE1nfhTy'
      result = Stripe::Customer.create({
        name: "#{first_name} #{last_name}",
        email: email,
      })
      update(stripe_customer_id: result.id)
      attach_stripe_payment_method(result.id, 'pm_card_ca') # Pass the customer ID and payment method token
    rescue Stripe::StripeError => e
      # Handle the error
      Rails.logger.error("Stripe Error: #{e.message}")
    end
  end

  private

  def attach_stripe_payment_method(customer_id, payment_method_token)
    Stripe::PaymentMethod.attach(
      payment_method_token,
      { customer: customer_id },
    )
  end
end