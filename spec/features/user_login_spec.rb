require 'rails_helper'

RSpec.feature "Visitor can login", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(first_name: 'Iamafake', last_name: 'Person', email: 'test@test.com', password: 'password', password_confirmation: 'password')
  end

  scenario "On correct credential submission user redirects to home page" do
    # ACT
    visit login_path
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'password'
    within('main') { click_on('Login') }


    # DEBUG / VERIFY
    within('nav') { expect(page).to have_content('Iamafake') }
    expect(page).to have_css 'section.products-index'
    save_screenshot
    # pp page.html
  end
end
