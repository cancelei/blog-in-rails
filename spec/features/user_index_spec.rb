require 'rails_helper'

RSpec.describe 'User index', type: :system do 
    describe 'index page' do 
        let(:users) { create_list(:user, 3) } 
        before do
            visit users_path # visit the user index page
          end
          it 'shows the username of all other users' do
            users.each do |user|
              expect(page).to have_content(user.name) # check if the page has the user name
            end
          end
        end
    end
        