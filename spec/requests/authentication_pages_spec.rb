require 'spec_helper'
require 'support/utilities'

describe "Authentication" do
  
  subject { page }

  describe "signin page" do
  	before { visit signin_path }

  	it { should have_content('Sign in') }
  	it { should have_title('Sign in') }
  end

  describe "signin" do
  	before { visit signin_path }

  	describe "with invalid information" do
  		before { click_button "Sign in" }

  		it { should have_title('Sign in') }
  		it { should have_error_message('Invalid') }

      describe "after visiting another page" do
      	before { click_link "Home" }
      	it { should_not have_error_message('Invalid') }
      end
  	end
  
    describe "with valid information" do
     	let (:user) { FactoryGirl.create(:user) }
     	before { sign_in(user) }

      it { should have_profile_title(user) }
      it { should have_profile }
      it { should have_link('Settings', href: edit_user_path(user)) }
      it { should be_signed_in }
      it { should_not be_signed_out }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should be_signed_out }
      end 
    end
  end
end
