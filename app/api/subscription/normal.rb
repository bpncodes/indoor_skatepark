require 'grape'

class Subscription::Normal < Grape::API
  format :json

  post '/subscribe_normal' do

      Customer.transaction do

      customer = Customer.find(params[:id])

      if customer.subscribe_to_plan("price_1P5BGRRuKjTLXSCQLv6PIlWU")
      { success: true, message: 'Subscription created successfully' }
      else
        error!({ error: "Cant make a Stripe subscription" }, 500)
      end

    end

  end
end

# Call using thistatus
# ab -n 10 -c 2 -p post_data.txt -T application/x-www-form-urlencoded http://localhost:3000/subscribe_normal
