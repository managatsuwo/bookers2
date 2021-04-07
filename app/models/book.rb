class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence:true
  validates :body, presence:true
  validates :body,    length: { maximum: 200 }
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(searaches,word)
                if searaches == "forward_match"
                        @books = Book.where("body LIKE?","#{word}%")
                elsif searaches == "backward_match"
                        @books = Book.where("body LIKE?","%#{word}")
                elsif searaches== "perfect_match"
                        @books = Book.where("body=?","#{word}")
                elsif searaches == "partial_match"
                        @books = Book.where("body LIKE?","%#{word}%")
                else
                        @books = Book.all
                end
  end
end
