class User < ApplicationRecord

  # * Relationship with friends (Self-Join)
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # * Relationship with group members
  has_and_belongs_to_many :groups

  # * Relationship with group ownership
  has_many :groups, foreign_key: :owner_id, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def friend_with?(friend_id)
    self.friends.where(id: friend_id).exists?
  end

  def get_image
    if image
      return image
    end
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    return "https://gravatar.com/avatar/#{gravatar_id}?s=32&d=identicon&r=PG"
  end

  def self.connect_to_facebook(auth, signed_in_resource = nil)
    puts "------>>>>>"
    puts auth.info
    puts "------<<<<<"
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          full_name: auth.info.name,
          provider: auth.provider, uid: auth.uid, email: auth.info.email,
          image: auth.info.image, password: Devise.friendly_token[0, 20],
        )
      end
    end
  end

  def self.connect_to_gmail(auth, signed_in_resource = nil)
    puts "------>>>>>"
    puts auth.info
    puts "------<<<<<"
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          full_name: auth.info.name,
          provider: auth.provider, uid: auth.uid, email: auth.info.email,
          image: auth.info.image, password: Devise.friendly_token[0, 20],
        )
      end
    end
  end
end
