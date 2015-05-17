class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validate :premium_user_creates_private_wiki, on: :create

  def premium_user_creates_private_wiki
    return unless wiki_private
    errors.add(:base, 'nnn') unless user.premium?
  end
end
