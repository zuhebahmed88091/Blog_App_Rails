require 'swagger_helper'

RSpec.describe 'api/my', type: :request do
    path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
        post 'Create a comment for a post' do
          tags 'Comments'
          consumes 'application/json'
    
          parameter name: 'user_id', in: :path, type: :string, required: true, description: 'User ID'
          parameter name: 'post_id', in: :path, type: :string, required: true, description: 'Post ID'
    
          parameter name: :comment, in: :body, schema: {
            type: :object,
            properties: {
              text: { type: :string, description: 'Comment text' }
            },
            required: ['text']
          }
    
          response '201', 'Comment created'
          response '422', 'Invalid request'
    
          let(:user_id) { 'user_id_here' }
          let(:post_id) { 'post_id_here' }
          let(:comment) { { text: 'This is a comment' } }
    
          run_test!
        end
      end
    
      path '/api/v1/users/{user_id}/posts' do
        get 'List all posts for a user' do
          tags 'Posts'
    
          parameter name: 'user_id', in: :path, type: :string, required: true, description: 'User ID'
    
          response '200', 'List of posts returned'
    
          let(:user_id) { 'user_id_here' }
    
          run_test!
        end
      end
    
      path '/api/v1/users' do
        get 'List all users' do
          tags 'Users'
    
          response '200', 'List of users returned'
    
          run_test!
        end
    
        post 'Create a new user' do
          tags 'Users'
          consumes 'application/json'
    
          parameter name: :user, in: :body, schema: {
            type: :object,
            properties: {
              name: { type: :string, description: 'User name' },
              email: { type: :string, description: 'User email' },
              bio: { type: :string, description: 'User bio' }
            },
            required: ['name', 'email']
          }
    
          response '201', 'User created'
          response '422', 'Invalid request'
    
          let(:user) { { name: 'John Doe', email: 'john@example.com', bio: 'Bio info' } }
    
          run_test!
        end
      end
    
      path '/api/v1/users/{id}' do
        get 'Retrieve user details' do
          tags 'Users'
    
          parameter name: 'id', in: :path, type: :string, required: true, description: 'User ID'
    
          response '200', 'User details returned'
          response '404', 'User not found'
    
          let(:id) { 'user_id_here' }
    
          run_test!
        end
    
      end
end