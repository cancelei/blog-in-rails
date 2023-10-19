require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Mohammad', photo: 'https://example.jpg', bio: 'Eng')

    # Create multiple posts for the user
    @posts = []
    (1..10).each do |i|
      @posts << Post.create(author: @user, title: "Post #{i}", body: "Body of post #{i}")
    end

    visit user_posts_path(@user)
  end

  scenario 'I can see the user\'s profile picture' do
    expect(page).to have_css('img.profile-photo') # Use 'profile-photo' instead of 'user-photo'
  end

  scenario 'I can see the user\'s username' do
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content("Number of posts: 10") # Assuming 10 posts were created in the before block
  end

  scenario 'I can see a post\'s title' do
    expect(page).to have_content(@posts.first.title)
  end

  scenario 'I can see some of the post\'s body' do
    expect(page).to have_content(@posts.first.body.truncate(100))
  end

  scenario 'I can see the first comments on a post' do
    expect(page).to have_content('Comments:')
    expect(page).to have_content('Comment 1')
    expect(page).to have_content('Comment 2')
  end

  scenario 'I can see how many comments a post has' do
    expect(page).to have_content('Comments: 2')
  end

  scenario 'I can see how many likes a post has' do
    # Add code to display the number of likes on the post, e.g., 'Likes: 5'
    expect(page).to have_content('Likes: 5')
  end

  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    # Assuming you have implemented pagination in your view
    expect(page).to have_css('ul.pagination')
  end

  scenario 'When I click on a post, it redirects me to that post\'s show page' do
    click_link @posts.first.title
    expect(page).to have_current_path(user_post_path(@user, @posts.first))
  end
end
