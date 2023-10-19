require 'rails_helper'

RSpec.describe 'Users index page', type: :feature do
  before do
    @user1 = User.create(name: 'Najib', photo: 'https://example.jpg', bio: 'Eng')
    @user2 = User.create(name: 'Joseph', photo: 'https://example.jpg', bio: 'Dev')
    @user3 = User.create(name: 'Glauber', photo: 'https://example.jpg', bio: 'Eng')
    visit('/users')
  end

  scenario 'user can see the username of all users' do
    expect(page).to have_content('Mohammad')
    expect(page).to have_content('John')
    expect(page).to have_content('Karim')
  end

  scenario 'user can see the profile picture for each user' do
    # Take all images by class name into an array
    all_img = all('img.user-photo')
    expect(all_img.size).to eq(3)

    # Each image should be present
    all_img.each do |img|
      expect(img).to be_present
    end
  end

  scenario 'user can see the number of posts' do
    # For each user, find the corresponding user element and check for the number of posts.
    users = User.all
    users.each do |user|
      user_element = find('.user-card', text: user.name)
      expect(user_element).to have_content("#{user.posts_counter} Posts")
    end
  end

  scenario 'click on a user, I am redirected to that user show page' do
    click_link('Mohammad')
    expect(page).to have_current_path(user_path(@user1))
  end
end
