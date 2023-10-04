class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  # has_many :comments
  # has_many :likes
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  attribute :title, :string
  attribute :text, :text
  attribute :comment_counter, :integer, default: 0
  attribute :like_counter, :integer, default: 0
  validates :title, presence: true, length: { maximum: 250 }
  validates :comment_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :like_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  after_save :update_post_counter
  after_destroy :update_post_counter
  def update_post_counter
    author.update(post_counter: author.posts.count)
  end
  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end