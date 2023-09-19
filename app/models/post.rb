class Post < ApplicationRecord
    belongs_to :author, class_name: 'User'
    has_many :comments
    has_many :likes

    attribute :title, :string
    attribute :text, :text
    attribute :comment_counter, :integer, default: 0
    attribute :like_counter, :integer, default: 0
end
