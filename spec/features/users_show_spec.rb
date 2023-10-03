require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'User Show Page', type: :feature do
  let(:user) { User.create(name: 'Tom', bio: 'Teacher from Mexico.') }
  let!(:post1) { Post.create(author: user, title: "Post title 1", text: 'Post Text 1') }
  let!(:post2) { Post.create(author: user, title: "Post title 2", text: 'Post Text 2') }
  let!(:post3) { Post.create(author: user, title: "Post title 3", text: 'Post Text 3') }

  before do
    user.update(photo: 'https://www.kasandbox.org/programming-images/avatars/cs-hopper-cool.png')
    Comment.create(user: user, post: post1, text: 'Comment 1')
    Comment.create(user: user, post: post2, text: 'Comment 2')
    Comment.create(user: user, post: post3, text: 'Comment 3')
    Like.create(user: user, post: post1)
  end

  scenario "I can see the user's profile picture" do
    visit user_path(user)

    expect(page).to have_selector('img[src="https://www.kasandbox.org/programming-images/avatars/cs-hopper-cool.png"]')
  end

  scenario "I can see the user's username" do
    visit user_path(user)

    expect(page).to have_content('Tom')
  end

  scenario "I can see the number of posts the user has written" do
    visit user_path(user)

    expect(page).to have_content('Number of posts: 3')
  end

  scenario "I can see the user's bio" do
    visit user_path(user)

    expect(page).to have_content('Teacher from Mexico.')
  end

  scenario "I can see the user's first 3 posts" do
    visit user_path(user)

    expect(page).to have_content('Post title 1')
    expect(page).to have_content('Post Text 1')
    expect(page).to have_content('Post title 2')
    expect(page).to have_content('Post Text 2')
    expect(page).to have_content('Post title 3')
    expect(page).to have_content('Post Text 3')
  end

  scenario "I can see a button that lets me view all of a user's posts" do
    visit user_path(user)
    expect(page).to have_link('See All Posts', href: user_posts_path(user))
  end
  scenario "When I click a user's post, it redirects me to that post's show page" do
    visit user_path(user)
    click_link 'Post title 1'
    expect(page).to have_current_path(user_post_path(user, post1))
  end
  scenario "When I click to see all posts, it redirects me to the user's post's index page" do
    visit user_path(user)
    click_link 'See All Posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
