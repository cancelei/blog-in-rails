require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /' do
    it 'renders the index template and has correct status' do
      get root_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of all users')
    end

    it 'renders the show template and has correct status for a specific user' do
      user = User.create!(email: 'test@example.com', name: 'Test User', bio: 'Test bio.')
      get user_path(user.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(user.name)
    end
  end
end
