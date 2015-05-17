class UserPolicy < ApplicationPolicy
  def edit?
    (@user.standard? || @user.admin? || @user.premium?) ? true : false
  end

  def delete?
    @user.admin? ? true : false
  end

  def create?
    @user.present?
  end

  def new?
    @user.present?
  end
end
