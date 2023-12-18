require 'stripe'
Rails.configuration.stripe = {
  :publishable_key => 'pk_test_51OMQDpBp9ilCXH51iSuTJz7V25r9PArJrhfcsyQYLb9haP19Mv0By7yBFpigImuKjlMfyzB9Cbv4SM8YK2BlGtWs00KXywtCHe',
  :secret_key => 'sk_test_51OMQDpBp9ilCXH51Zo4tHckHo64gyGqrHBnJWn1swq3lSG0POBykVCyemNVMSoRSHpgs8Wx8T2NIRb8x3CERxZyt00Dq95a7gk'
  
}

StripeEvent.configure do |events|
  events.subscribe 'checkout.session.completed' do |event|
    # Handle the 'checkout.session.completed' event here
    StripeWebhooksController.new(:checkout_session_completed).call(event)
  end
  # Add other event subscriptions as needed
end
Stripe.api_key = Rails.configuration.stripe[:secret_key]
