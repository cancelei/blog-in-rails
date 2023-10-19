class User < ApplicationRecord
  # Associations
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  # Validations
  validates :name, presence: true
  validates :email, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Methods
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
