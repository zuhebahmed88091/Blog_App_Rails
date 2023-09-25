require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'Returns a successful response' do
      get posts_path
      expect(response).to have_http_status(:success)
    end

    it 'Returns correct template' do
      get posts_path
      expect(response).to render_template(:index)
    end

    it 'Includes correct placeholder text in the response body' do
      get posts_path
      expect(response.body).to include('Here is the all of posts for given user with comments')
    end
  end

  describe 'GET #show' do
    subject { Post.create(id: 1, title: 'Post 1', text: 'This is the sample post') }

    it 'Returns a successful response' do
      get post_path(subject.id)
      expect(response).to have_http_status(:success)
    end

    it 'Returns correct template' do
      get post_path(subject)
      expect(response).to render_template(:show)
    end

    it 'Includes correct placeholder text in the response body' do
      get post_path(subject)
      expect(response.body).to include('All details posts for a given user')
    end
  end
end
