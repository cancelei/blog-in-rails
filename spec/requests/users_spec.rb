require 'rails_helper'

RSpec.describe 'Users', type: :request do

  describe 'GET /index' do
    it 'renders the index template' do
      get root_path
      expect(response).to render_template(:index)
    end

    it 'has a status of 200' do
      get root_path
      expect(response).to have_http_status(200)
    end

    it 'displays a list of all users' do
      get root_path
      expect(response.body).to include('List of all users')
    end
  end

  describe 'GET /show' do
    let(:user) { User.create!(email: 'test@example.com', name: 'Test User', bio: 'Test bio.') }

    it 'renders the show template' do
      get user_path(user.id)
      expect(response).to render_template(:show)
    end

    it 'has a status of 200' do
      get user_path(user.id)
      expect(response).to have_http_status(200)
    end

    it 'displays the name of the user' do
      get user_path(user.id)
      expect(response.body).to include(user.name)
    end
  end

end
