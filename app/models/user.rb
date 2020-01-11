class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: 'author_id'
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :likes, dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy

  def is_friend?(another_user)
    friends.include?(another_user)
  end

  def pending?(another_user)
    friend_requests.find_by(friend_id: another_user.id)
  end

  def remove_friend(friend)
    friends.destroy(friend)
  end

  def find_like(post_id)
    likes.where(post_id: post_id, user_id: id)
  end

  def liked?(post_id)
    likes.where(post_id: post_id, user_id: id).any?
  end
end
