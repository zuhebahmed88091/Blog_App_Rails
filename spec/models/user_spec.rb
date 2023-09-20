require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Zafri') }

  before { subject.save }

  describe 'validation tests' do
    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'name should be present' do
      subject.name = 'Zafri'
      expect(subject).to be_valid
    end

    it 'posts_counter should be integer' do
      subject.post_counter = 'hey'
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to zero' do
      subject.post_counter = -2
      expect(subject).to_not be_valid
      subject.post_counter = 2
      expect(subject).to be_valid
    end
  end

  describe '#three_most_recent_posts' do
    it 'should return three most recent posts' do
      user = User.create(name: 'Nahuel')
      Post.create(title: 'Title1', author: user, created_at: 4.day.ago)
      post2 = Post.create(title: 'Title2', author: user, created_at: 3.day.ago)
      post3 = Post.create(title: 'Title3', author: user, created_at: 2.day.ago)
      post4 = Post.create(title: 'Title4', author: user, created_at: 1.day.ago)
      expect(user.recent_posts).to eq([post4, post3, post2])
    end
  end
end
