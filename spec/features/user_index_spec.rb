require 'rails_helper'

RSpec.describe 'User index', type: :system do 
    describe 'index page' do  
        before do
            @user1 = User.create(name: 'Mohammad', photo: 'https://example.jpg', bio: 'Eng')
            @user2 = User.create(name: 'Mohammad1', photo: 'https://example.jpg2', bio: 'Eng')
            @user3 = User.create(name: 'Mohammad2', photo: 'https://example.jpg3', bio: 'Eng', posts_counter: 2)
          end
          it 'shows the username of all users' do
            visit users_path
            expect(page).to have_content(@user1.name)
            expect(page).to have_content(@user1.name)
          end
          it 'Shows the profile picture of all users' do
            visit users_path
            expect(page).to have_css("img.user-photo[src*='https://example.jpg3']")
            expect(page).to have_css("img.user-photo[src*='https://example.jpg2']")
          end

          it 'Shows the number of user has writen' do
            visit users_path
            expect(page).to have_content('2 Posts')
            expect(page).to have_content('0 Posts')
          end

          it "Redirected user's show page When I click on a user" do
            visit users_path
            click_link 'Mohammad'
            expect(page).to have_current_path(user_path(@user1))
          end
        end
    end
        