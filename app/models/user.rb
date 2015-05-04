class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  after_initialize :defaults

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  def can_edit?
    (self.standard? || self.admin? || self.premium?) ? true : false
  end

  def can_delete?
    self.admin? ? true : false
  end

  def defaults
    self.role = 'standard'
  end
end
