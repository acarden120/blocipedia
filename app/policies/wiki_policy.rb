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

  # rubocop:disable CyclomaticComplexity, MethodLength, PerceivedComplexity, Metrics/AbcSize
  def show?
    if user.present?
      if user.premium? || user.admin?
        record.public? || record.user == user || record.users.include?(user)
      elsif user.standard?
        record.public? || record.users.include?(user)
      end
    else
      record.public?
    end
  end
  # rubocop:enable CyclomaticComplexity, MethodLength, PerceivedComplexity, Metrics/AbcSize

  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # rubocop:disable CyclomaticComplexity, MethodLength, PerceivedComplexity, Metrics/AbcSize
    def resolve
      wikis = []
      if user.present? && user.role == 'admin'
        wikis = scope.all.order('created_at desc') # if the user is an admin, show them all the wikis
      elsif user.present? && user.role == 'premium'
        all_wikis = scope.all.order('created_at desc')
        all_wikis.each do |wiki|
          if wiki.public? || wiki.user == user || wiki.users.include?(user)
            wikis << wiki
          end
        end
      elsif user.present? && user.role == 'standard' # this is the lowly standard user
        all_wikis = scope.all.order('created_at desc')
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.users.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      else
        wikis = scope.all.where(wiki_private: false).order('created_at desc')
      end
      # rubocop:enable CyclomaticComplexity, MethodLength, PerceivedComplexity, Metrics/AbcSize
      wikis # return the wikis array we've built up
    end
  end
end
