class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  validates :title, length: { minimum: 2 }, presence: true
  validates :body, length: { minimum: 10 }, presence: true
  validate :premium_user_creates_private_wiki, on: :create

  def public?
    wiki_private == false
  end

  protected

  def premium_user_creates_private_wiki
    return unless wiki_private
    errors.add(:base, 'Only premium user can create private wiki') unless user.premium? || user.admin?
  end
end
