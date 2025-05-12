class PaymentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: event.title,
            description: event.description
          },
          unit_amount: event.price, # in cents
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: "#{root_url}success?event_id=#{event.id}",
      cancel_url: "#{root_url}events/#{event.id}"
    )

    redirect_to session.url, allow_other_host: true
  end
end
