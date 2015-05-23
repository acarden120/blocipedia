class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :collaborations
  has_many :wikis, through: :collaborations

  after_update :update_private_wikis

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  
#  def collaborations
#    Collaboration.where(user_id: id)
#  end

  protected

  def update_private_wikis
    return unless role_was == 'premium' && role == 'standard'
    wikis.all.update_all(wiki_private: false)
  end
end
