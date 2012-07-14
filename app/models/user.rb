class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid

  has_and_belongs_to_many :roles
  
  has_many :pins
  has_many :items, :through => :pins

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def make_admin
    self.roles << Role.admin
  end

  def revoke_admin
    self.roles.delete(Role.admin)
  end

  def admin?
    role?(:admin)
  end

  def pin!(item)
    pins.create!(item_id: item.id)
  end

  def unpin!(item)
    pins.find_by_item_id(item.id).destroy
  end

  def pinned?(item)
    pins.find_by_item_id(item)
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         image: auth.info.image,
                         password: Devise.friendly_token[0,20])
    end
    return user
  end

end
