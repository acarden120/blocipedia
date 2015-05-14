class UserPolicy < ApplicationPolicy
  def can_edit?
    (@user.standard? || @user.admin? || @user.premium?) ? true : false
  end

  def can_delete?
    @user.admin? ? true : false
  end

  def create_private?
    @user.premium? ? true : false
  end

end
