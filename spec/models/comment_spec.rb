# spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  # For the sake of creating valid objects during testing
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }
  let(:valid_comment) { FactoryBot.build(:comment, user:, post:) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(valid_comment).to be_valid
    end

    it 'is not valid without content' do
      valid_comment.content = nil
      expect(valid_comment).to_not be_valid
    end

    it 'is not valid without an associated user' do
      valid_comment.user = nil
      expect(valid_comment).to_not be_valid
    end

    it 'is not valid without an associated post' do
      valid_comment.post = nil
      expect(valid_comment).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  # When you have scopes or class methods, you can add them here.

  # When you have instance methods, you can add them here.
end
