class UsersController < ApplicationController
  def update
  end

  def downgrade
    @user = current_user
    @wikis = @user.wikis
    if current_user.update(role: 'standard')
      if current_user.update_private_wikis
        flash[:notice] = "Account downgraded successfully."
       else
        flash[:error] = "There was an error. Please try again."
      end
    end
  end
 
  private
 
  def user_params
    params.require(:user).permit(:name)
  end
end
