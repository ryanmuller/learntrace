class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :image, :name, :username

  has_and_belongs_to_many :roles
  
  has_many :pins, dependent: :destroy
  has_many :items, :through => :pins
  has_many :streams, dependent: :destroy

  before_create :default_username

  default_scope order("updated_at DESC")

  #validates_presence_of :name, :on => :update

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def make_admin
    self.roles << Role.admin
  end

  def image
    read_attribute(:image) || write_attribute(:image, "/assets/gravatar-holder.jpg")
  end

  def display_name
    if name.blank?
      "Anonymous Learner"
    else
      name
    end
  end

  def revoke_admin
    self.roles.delete(Role.admin)
  end

  def admin?
    role?(:admin)
  end

  def pin!(item, stream)
    pins.create!(item_id: item.id, stream_id: stream.id)
  end

  def pin_and_copy!(item, stream)
    pin=pin!(item, stream)
    pin.copy_to_forks
    return pin
  end

  def unpin!(pin)
    pin.destroy
  end

  def pinned?(item)
    pins.find_by_item_id(item)
  end

  def apply_omniauth(auth)
    self.email = auth.info.email
    self.image = auth.info.image
    self.name = auth.info.name
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider: auth.provider,
                         uid: auth.uid,
                         password: Devise.friendly_token[0,20])
    end
    user.apply_omniauth(auth)
    return user
  end

  def stream_options
    streams.map { |s| [s.name, s.id] }
  end

  def stream_names
    streams.map { |s| s.name }
  end


  def to_s
    name || "Anonymous user"
  end

  def username
    read_attribute(:username) || self.id.to_s
  end

  def public_streams
    streams.where("public = true")
  end

  private
  def default_username
    self.username = self.name.nil? ? (rand()*10000).to_i.to_s : self.name.sub(/[^a-zA-Z0-9_\-\.]/, ".").downcase
  end
end
