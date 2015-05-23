class Collaboration < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user

#  attr_accessible :wiki_id, :user_id

  def self.wikis
    Wiki.where( id: pluck(:wiki_id))
  end

  def self.users
  	User.where( id: pluck(:user_id))
  end

  def user
  	User.find(user_id)
  end

  def wiki
  	Wiki.find(wiki_id)
  end
end
