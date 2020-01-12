class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :posts, foreign_key: 'author_id'
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :likes, dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid)
      .first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

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
