# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  # For the sake of creating valid objects during testing
  let(:valid_user) { build(:user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(valid_user).to be_valid
    end

    it 'is not valid without a name' do
      valid_user.name = nil
      expect(valid_user).to_not be_valid
    end

    it 'is not valid without an email' do
      valid_user.email = nil
      expect(valid_user).to_not be_valid
    end

    # Add more validation tests as needed.
  end

  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments) }
    # ... add other associations as needed
  end

  # When you have scopes or class methods, you can add them here.

  # When you have instance methods, you can add them here.
end
