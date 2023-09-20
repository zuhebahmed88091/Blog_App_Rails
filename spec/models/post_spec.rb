require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Mind your surroundings', author: User.create(name: 'Zuheb')) }

  before { subject.save }

  describe 'validation tests' do
    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid if title length exceeds 250 characters' do
      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'comment_counter should be integer' do
      subject.comment_counter = 'How do you do'
      expect(subject).to_not be_valid
    end

    it 'comment_counter should be greater than or equal to zero' do
      subject.comment_counter = -1
      expect(subject).to_not be_valid
      subject.comment_counter = 4
      expect(subject).to be_valid
    end

    it 'like_counter should be integer' do
      subject.like_counter = 'Whats up'
      expect(subject).to_not be_valid
    end

    it 'like_counter should be greater than or equal to zero' do
      subject.like_counter = -2
      expect(subject).to_not be_valid
      subject.like_counter = 2
      expect(subject).to be_valid
    end
  end

  describe '#update_post_counter' do
    it 'updates the user post_counter attribute' do
      user = User.create(name: 'Martin')
      post1 = Post.create(title: 'Title 1', author: user)
      post2 = Post.create(title: 'Title 2', author: user)

      post1.update_post_counter
      post2.update_post_counter

      expect(user.reload.post_counter).to eq(2)
    end
  end

  describe '#recent_comments' do
    it 'returns the 5 most recent comments' do
      user = User.create(name: 'Ahmed')
      Comment.create(user:, post: subject, text: 'comment 1', created_at: 5.day.ago)
      comment2 = Comment.create(user:, post: subject, text: 'comment 2', created_at: 4.day.ago)
      comment3 = Comment.create(user:, post: subject, text: 'comment 3', created_at: 3.day.ago)
      comment4 = Comment.create(user:, post: subject, text: 'comment 4', created_at: 2.day.ago)
      comment5 = Comment.create(user:, post: subject, text: 'comment 5', created_at: 1.day.ago)
      comment6 = Comment.create(user:, post: subject, text: 'comment 6', created_at: Time.now)

      recent_comments = subject.recent_comments

      expect(recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end
end
