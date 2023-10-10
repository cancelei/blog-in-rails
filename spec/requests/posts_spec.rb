require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create!(email: 'test@example.com', name: 'Test User', bio: 'Test bio.') }

  describe 'GET /users/:user_id/posts' do
    it 'renders the index template and has correct status' do
      get user_posts_path(user.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of posts for User')
    end

    it 'renders the show template and has correct status for a specific post' do
      post = Post.create!(title: 'Test Post', body: 'This is a test post.', author: user)
      get user_post_path(user.id, post.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(post.title)
    end
  end
end
