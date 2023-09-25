require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    it 'Returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'Returns correct template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'Includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is the list of all users')
    end
  end

  describe 'GET #show' do
    subject { User.create(name: 'Linas Ahmed') }

    it 'Returns a successful response' do
      get user_path(subject)
      expect(response).to have_http_status(:success)
    end

    it 'Returns correct template' do
      get user_path(subject)
      expect(response).to render_template(:show)
    end

    it 'Includes correct placeholder text in the response body' do
      get user_path(subject)
      expect(response.body).to include('The profile of individual user')
    end
  end
end
