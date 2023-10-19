require 'rails_helper'
require 'selenium-webdriver'

RSpec.feature 'UserInteractions', type: :feature do
  let(:user) { create(:user) } # Assuming you have factories set up
  # let(:post) { create(:post, author: user) } # Assuming you have factories set up

  scenario 'User views their profile with correct post count' do
    driver = Selenium::WebDriver.for :chrome # Use the appropriate browser driver (e.g., :firefox) here
    visit user_path(user, driver: driver)
    expect(page).to have_content(user.name) if user.name.present?
    expect(page).to have_content(user.bio) if user.bio.present?
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
    driver.quit
  end

  scenario 'User navigates from profile to one of their posts' do
    specific_title = 'Specific Test Title'
    specific_body = 'This is a test post.'
    post = create(:post, author: user, title: specific_title, body: specific_body)
    driver = Selenium::WebDriver.for :chrome # Use the appropriate browser driver (e.g., :firefox) here
    visit user_path(user, driver: driver)
    click_on specific_title
    # expect(page).to have_current_path(post_path(post))
    expect(page).to have_content(specific_title)
    expect(page).to have_content(post.body) if post.body.present?
    driver.quit
  end

  scenario 'User creates a new post and post count increases' do
    driver = Selenium::WebDriver.for :chrome # Use the appropriate browser driver (e.g., :firefox) here
    visit user_path(user, driver: driver)
    initial_post_count = user.posts_counter
    click_link 'Create New Post'
    sleep(5)
    find('#post_title_field').set('Specific Test Title')
    sleep(5)
    find('#post_body').set('This is the body of the test post.')
    click_on 'Create Post'
    expect(page).to have_current_path(post_path(Post.order(created_at: :asc).first))
    expect(user.reload.posts_counter).to eq(initial_post_count + 1)
    driver.quit
  end

  scenario 'Post displays the correct number of comments and likes' do
    post = create(:post, author: user)
    driver = Selenium::WebDriver.for :chrome # Use the appropriate browser driver (e.g., :firefox) here
    visit user_post_path(user, post, driver: driver)
    expect(page).to have_content("Comments: #{post.comments_counter}")
    expect(page).to have_content("Likes: #{post.likes_counter}")
    driver.quit
  end
end