class ChargesController < ApplicationController
  # rubocop:disable MethodLength, Metrics/AbcSize
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 1500,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    if current_user.update(role: 'premium')
      flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    else
      flash[:success] = 'There was an error upgrading your account. Please contact support!'
    end

    redirect_to edit_user_registration_path

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end
  # rubocop:enable MethodLength, Metrics/AbcSize

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: 1500
    }
  end
end
