class WikiPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def create_private?
    user.present? && user.premium?
  end

  def add_collaborator?
    user.present? && user.premium? && !record.public?
  end

  def show?
    if user.present? && (user.premium? || user.admin?)
      record.user == user || record.users.include?(user)
    elsif user.present? && user.standard?
      record.public? || record.users.include?(user)
    else
      record.public?
    end
  end

  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # rubocop:disable all
    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all.order('created_at desc') # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
#        all_wikis = scope.all.order('created_at desc')
        all_wikis = scope.all.order('created_at desc')
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all.order('created_at desc')
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.users.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
    # rubocop:enable all
  end
end
