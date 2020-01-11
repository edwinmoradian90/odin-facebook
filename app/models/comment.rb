class Comment < ApplicationRecord
  scope :desc, -> { order(created_at: :desc)}
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

end
