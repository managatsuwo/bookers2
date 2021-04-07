class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books,dependent: :destroy
  attachment :profile_image
  validates :name, uniqueness: true
  validates :name,    length: { in: 2..20 }
  validates :introduction,    length: { maximum: 50 }
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :followed

  def followed_by?(user)
    passive_relationships.find_by(follower_id: user.id).present?
  end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search(method,word)
                if method == "forward_match"
                        @users = User.where("text LIKE?","#{word}%")
                elsif method == "backward_match"
                        @users = User.where("text LIKE?","%#{word}")
                elsif method == "perfect_match"
                        @users = User.where("#{word}")
                elsif method == "partial_match"
                        @users = User.where("text LIKE?","%#{word}%")
                else
                        @users = User.all
                end
  end

end