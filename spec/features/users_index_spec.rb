require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  let!(:user1) { User.create(name: 'User 1', post_counter: 3, photo: 'https://www.kasandbox.org/programming-images/avatars/leafers-seed.png') }
  let!(:user2) { User.create(name: 'User 2', post_counter: 5, photo: 'https://www.kasandbox.org/programming-images/avatars/leafers-seedling.png') }
  let!(:user3) { User.create(name: 'User 3', post_counter: 2, photo: 'https://www.kasandbox.org/programming-images/avatars/leafers-sapling.png') }

  scenario 'I can see the username of all other users' do
    visit users_path

    expect(page).to have_content('User 1')
    expect(page).to have_content('User 2')
    expect(page).to have_content('User 3')
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    expect(page).to have_selector('img[src="https://www.kasandbox.org/programming-images/avatars/leafers-seed.png"]')
    expect(page).to have_selector('img[src="https://www.kasandbox.org/programming-images/avatars/leafers-seedling.png"]')
    expect(page).to have_selector('img[src="https://www.kasandbox.org/programming-images/avatars/leafers-sapling.png"]')
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_content('Number of posts: 5')
    expect(page).to have_content('Number of posts: 2')
  end

  scenario 'clicking on a user redirects to their show page' do
    user = User.create(name: 'Messi')

    visit users_path

    click_link 'Messi'

    expect(page).to have_current_path(user_path(user))
  end
end
