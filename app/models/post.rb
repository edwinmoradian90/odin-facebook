class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments
end
