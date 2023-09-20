require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#update_comment_counter' do
    it 'updates the post comment_counter attribute' do
      user = User.create(name: 'Linas')
      post = Post.create(title: 'Holla', author: user)
      comment1 = Comment.create(user: user, post: post)
      comment2 = Comment.create(user: user, post: post)

      comment1.update_comment_counter
      comment2.update_comment_counter

      expect(post.reload.comment_counter).to eq(2)
    end
  end
end