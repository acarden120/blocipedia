class WikiPolicy < ApplicationPolicy
  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end

  def edit?
  	user.present?
  end
end