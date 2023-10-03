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

  scenario "I can see the user's profile picture, username, no of posts, bio" do
    visit user_path(user)

    expect(page).to have_selector('img[src="https://www.kasandbox.org/programming-images/avatars/cs-hopper-cool.png"]')
    expect(page).to have_content('Tom')
    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_content('Teacher from Mexico.')
  end

  scenario 'redirects to the post\'s show page when you click on a user\'s post' do
    visit user_path(user)
    click_link 'Post title 1'
    expect(page).to have_current_path(user_post_path(user, post1))
  end

  scenario 'redirects to the user\'s post\'s index page when you click on "See All Posts" button' do
    visit user_path(user)
    click_link 'See All Posts', wait: 10
    expected_path = user_posts_path(user).chomp('/')
    expect(page).to have_current_path(expected_path)
  end
end
