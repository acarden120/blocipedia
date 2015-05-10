class UsersController < ApplicationController
  def update
  end

  def downgrade
    if current_user.update(role: 'standard') && current_user.update_private_wikis
      flash[:notice] = 'Account downgraded successfully.'
    else
      flash[:error] = 'There was an error. Please try again.'
    end
    redirect_to edit_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
