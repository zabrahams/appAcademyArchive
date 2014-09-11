require 'spec_helper'
require 'support/utilities'

describe "User pages" do
  
  subject { page } 

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_profile_title(user) }
  end

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', 'Sign up') }
  	it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_flash_message("Name can't be blank") }
        it { should have_flash_message("Email can't be blank") }
        it { should have_flash_message("Email is invalid") }
        it { should have_flash_message("Password can't be blank") }
        it { should have_flash_message("Password is too short") }
      end
    end

    describe "with a password that doesn't match confirmation" do
      before do
        fill_create_form_with_valid_info
        fill_in "Confirmation", with: "notmatching"
      end

      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_flash_message("Password confirmation doesn't match") }
      end
    end

    describe "with an email that is already taken" do
      before do
        fill_create_form_with_valid_info
        user_with_same_email = get_user_with_same_email
        user_with_same_email.save
      end

      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_flash_message("Email has already been taken") }
      end
    end
    
    describe "with valid information" do
      before { fill_create_form_with_valid_info }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should be_signed_in }
        it { should have_profile_title(user) }
        it { should have_success_message("Welcome") }
      end
    end
  end
end