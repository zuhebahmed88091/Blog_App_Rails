class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  attribute :text, :text

  after_create :update_comment_counter
  after_destroy :update_comment_counter

  def update_comment_counter
    post.update(comment_counter: post.comments.count)
  end
end
