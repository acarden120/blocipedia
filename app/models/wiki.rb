class Wiki < ActiveRecord::Base
  belongs_to :user
  
  has_many :collaborations
  has_many :users, through: :collaborations

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validate :premium_user_creates_private_wiki, on: :create

  def public?
    wiki_private == false
  end

  def premium_user_creates_private_wiki
    return unless wiki_private
    errors.add(:base, 'nnn') unless user.premium? || user.admin?
  end

#  def collaborations
#  	Collaboration.where(wiki_id: id)
#  end
end
