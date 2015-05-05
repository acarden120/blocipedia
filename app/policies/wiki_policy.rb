class WikiPolicy < ApplicationPolicy
  def update?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end
end
