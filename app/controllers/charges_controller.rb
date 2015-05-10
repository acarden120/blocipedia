class ChargesController < ApplicationController
 def create 
   user = current_user

   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: 1000,
     description: "BigMoney Membership - #{user.email}",
     currency: 'usd'
   )
 
   if user.update(role: 'premium')
     flash[:success] = "Thanks for all the money, #{user.email}! Feel free to pay me again."
     redirect_to edit_user_registration_path
   else
     flash[:success] = "There was an error upgrading your account. Please contact support!"
     redirect_to edit_user_registration_path
   end

   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charge_path
   end

 def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.name}",
     amount: 1000
   }
 end

 def update
   user = current_user
   
   if user.update(role: 'standard')
     flash[:success] = "Your account has been downgraded to a standard account"
     redirect_to edit_user_registration_path
   else
     flash[:error] = "There was a problem downgrading your acccount. Please try again."     
   end
 end
end
