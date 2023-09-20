require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_like_counter' do
    it 'updates the post like_counter attribute' do
      user1 = User.create(name: 'Alice')
      user2 = User.create(name: 'Nohain')
      post = Post.create(title: 'Amazing Post', author: user1)
      like1 = Like.create(user: user1, post:)
      like2 = Like.create(user: user2, post:)

      like1.update_like_counter
      like2.update_like_counter

      expect(post.reload.like_counter).to eq(2)
    end
  end
end
