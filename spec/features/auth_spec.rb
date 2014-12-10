# spec/features/auth_spec.rb

require 'spec_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content 'New User'
  end


  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      signup('Mr. User', '123456')

      expect(page).to have_content 'Mr. User'

    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    signup('Mr. User', '123456')
    click_button "Logout"
    signin('Mr. User', '123456')
    expect(page).to have_content 'Mr. User'

  end

end

feature "logging out" do
  let(:new_user) { create(:user) }

  scenario "begins with logged out state" do
    visit goals_url
    expect(page).to have_content 'Sign In'
  end

  scenario "doesn't show username on the homepage after logout" do
    signup(user.username, user.password)
    click_button "Logout"
    expect(page).to_not have_content user.username
  end

end
