require 'rails_helper'

RSpec.feature 'Post Show Page', type: :feature do
  let(:user) { User.create(name: 'Tom') }
  let(:post) { Post.create(author: user, title: 'Post Title', text: 'Post Text') }

  before do
    user.update(photo: 'https://www.kasandbox.org/programming-images/avatars/cs-hopper-cool.png')
    Comment.create(user:, post:, text: 'Comment 1')
    Comment.create(user:, post:, text: 'Comment 2')
    Like.create(user:, post:)
  end

  scenario "I can see the post's title, author, comments, likes, body, and comment details" do
    visit user_post_path(user, post)

    expect(page).to have_content('Post Title')
    expect(page).to have_content('by Tom')
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Likes: 1')
    expect(page).to have_content('Post Text')

    within('.userC') do
      expect(page).to have_content('Tom: Comment 1')
      expect(page).to have_content('Tom: Comment 2')
    end
  end
end
