include ApplicationHelper

def sign_in(user, options={})
	if options[:no_capybara]
		# Sign in when not using Capybara.
		remember_token = User.new_remember_token
		cookies[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
	else
		visit signin_path
	  fill_in "Email",     with: user.email
	  fill_in "Password",  with: user.password 
	  click_button "Sign in"
	end
end

def fill_create_form_with_valid_info
	fill_in "Name",         with: "Example User"
  fill_in "Email",        with: "user@example.com"
  fill_in "Password",     with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

def get_user_with_same_email
  User.new(name: "Example User", email: "user@example.com", password: "foobar",
  	       password_confirmation: "foobar")
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		expect(page).to have_selector('div.alert.alert-error', text: message)
	end
end


RSpec::Matchers.define :have_success_message do |message|
	match do |page|
		expect(page).to have_selector('div.alert.alert-success', text: message)
	end
end

RSpec::Matchers.define :have_profile_title do |user| 
	match do |page|
	  expect(page).to have_title(user.name)
	end
end

RSpec::Matchers.define :have_profile do
	match do |page|
	  expect(page).to have_link('Profile')
	end
end

RSpec::Matchers.define :be_signed_in do
	match do |page|
	  expect(page).to have_link('Sign out')
	end
end

RSpec::Matchers.define :be_signed_out do
	match do |page|
		expect(page).to have_link('Sign in')
	end
end

RSpec::Matchers.define :have_flash_message do |message|
	match do |page|
		expect(page).to have_selector('li', text: "* #{message}")
	end
end