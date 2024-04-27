require 'grape'

class Subscription::Race < Grape::API
  format :json

  post '/subscribe_race' do

      customer = Customer.find(params[:id])

      if customer.subscribe_to_plan("price_1P5BGRRuKjTLXSCQLv6PIlWU")
      { success: true, message: 'Subscription created successfully' }
      else
        error!({ error: "Cant make a Stripe subscription" }, 500)
      end

  end
end

# Call using this
# curl -X POST http://localhost:3000/subscribe_race?id=1
# ab -n 10 -c 2 -p post_data.txt -T application/x-www-form-urlencoded http://localhost:3000/subscribe_race
