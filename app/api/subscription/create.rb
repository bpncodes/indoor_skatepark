require 'grape'

class Subscription::Create < Grape::API
  format :json

  post '/subscribe' do
      customer = Customer.find(params[:id])
      if customer.subscribe_to_plan("price_1P5BGRRuKjTLXSCQLv6PIlWU")
      { success: true, message: 'Subscription created successfully' }
      else
        error!({ error: "Cant make a Stripe subscription" }, 500)
      end
  end
end

# Call using this
tatus
 curl -X POST http://localhost:3000/subscribe?id=15
