require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  let(:user) { User.create(name: 'Tom', bio: 'Teacher from Mexico.') }
  let!(:post1) { Post.create(author: user, title: 'Post title 1', text: 'Post Text 1') }
  let!(:post2) { Post.create(author: user, title: 'Post title 2', text: 'Post Text 2') }
  let!(:post3) { Post.create(author: user, title: 'Post title 3', text: 'Post Text 3') }

  before do
    user.update(photo: 'https://www.kasandbox.org/programming-images/avatars/cs-hopper-cool.png')
    Comment.create(user:, post: post1, text: 'Comment 1')
    Comment.create(user:, post: post2, text: 'Comment 2')
    Comment.create(user:, post: post3, text: 'Comment 3')
    Like.create(user:, post: post1)
  end

  scenario "I can see the user's profile picture, username, no of posts, bio, first three posts" do
    visit user_path(user)

    expect(page).to have_content('Post title 1')
    expect(page).to have_content('Post Text 1')
    expect(page).to have_content('Post title 2')
    expect(page).to have_content('Post Text 2')
    expect(page).to have_content('Post title 3')
    expect(page).to have_content('Post Text 3')
  end
end
