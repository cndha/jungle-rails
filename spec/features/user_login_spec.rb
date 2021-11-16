require 'rails_helper'

RSpec.feature "User Logins", type: :feature, js: true do
  
  before :each do
    @user = User.create!(
      name: 'Alice',
      email: 'alice@wonderland.ca',
      password: 'goongoon',
      password_confirmation: 'goongoon'
    )
  end

  scenario 'User can login and is automatically redirected to homepage' do
    #ACT
    visit login_path
    fill_in 'email', with: 'alice@wonderland.ca'
    fill_in 'password', with: 'goongoon'
    click_button "Log In"
    
    #VERIFY
    expect(page).to have_content 'Logout'
    expect(page).to have_text 'Signed in as Alice'
    
    #DEBUG
    # save_screenshot 
  end

end
