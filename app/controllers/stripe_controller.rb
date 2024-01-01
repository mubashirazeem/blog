class StripeController < ApplicationController
  require 'stripe'

  def create
    line_items = []

    line_items << {
      price_data: {
        currency: 'usd',
        product_data: {
          name: current_user.email,
          name: current_user.user_name,
          description: current_user.bio,
        },
        unit_amount: 1000,
      },
      quantity: 1,
    }

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: "http://localhost:3000/checkout/success",
      cancel_url: stripe_cancel_url,
    )

    session[:stripe_session_id] = @session&.id
    redirect_to @session.url, allow_other_host: true
  end

  def handle_payment_success
    if current_user.present?
      current_user.update(payment_status: 'paid')
    end
    redirect_to root_url
  end


  private

  def stripe_success_url
    root_url
    redirect_to 
  end

  def stripe_cancel_url
    root_url
  end
end