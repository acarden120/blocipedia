class UsersController < ApplicationController
  after_update update_private_wikis

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

  private

  def update_private_wikis
    current_user.wikis.all.update_all(public: true)
  end
end
