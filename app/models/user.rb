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

  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end

end