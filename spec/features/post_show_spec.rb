require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  before(:all) do
    @user = User.create(name: 'Najib')
    @post = Post.create(title: 'Test Post', body: 'This is the body of the post', author: @user)
    @comments = [
      Comment.create(user: @user, post: @post, content: 'Comment 1'),
      Comment.create(user: @user, post: @post, content: 'Comment 2')
    ]
    Like.create(user: @user, post: @post)
  end

  it 'I can see the post title' do
    visit post_path(@post)
    expect(page).to have_content(@post.text)
  end

  it 'I can see who wrote the post' do
    visit post_path(@post)
    expect(page).to have_content(@user.name)
  end

  it 'I can see how many comments it has' do
    visit post_path(@post)
    expect(page).to have_content('Comments: 2') # Assuming 2 comments were created
  end

  it 'I can see how many likes it has' do
    visit post_path(@post)
    expect(page).to have_content('Likes: 1')
  end

  it 'I can see the post body' do
    visit post_path(@post)
    expect(page).to have_content(@post.body)
  end

  it 'I can see the username of each commentor' do
    visit post_path(@post)
    @comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'I can see the comment each commentor left' do
    visit post_path(@post)
    @comments.each do |comment|
      expect(page).to have_content(comment.content)
    end
  end
end
