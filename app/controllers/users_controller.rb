class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
  end

  def downgrade
    if current_user.update(role: 'standard')
      flash[:notice] = 'Account downgraded successfully.'
    else
      flash[:error] = 'There was an error. Please try again.'
    end
    redirect_to edit_user_registration_path
  end
end
