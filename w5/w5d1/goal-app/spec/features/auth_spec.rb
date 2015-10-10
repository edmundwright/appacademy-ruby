require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  it "has a new user page" do
    visit "/users/new"
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    it "shows username on the homepage after signup" do
      sign_up(username: "Fred", password: "test_password")
      expect(page).to have_content "Fred"
    end

    it "displays an error if no password" do
      sign_up(username: "Fred")

      expect(page).to have_content "Password is too short"
    end

    it "displays an error if password too short" do
      sign_up(username: "Fred", password: "test")
      expect(page).to have_content "Password is too short"
    end

    it "displays an error if no username" do
      sign_up(password: "test_password")

      expect(page).to have_content "Username can't be blank"
    end

    it "displays an error if username not unique" do
      2.times { sign_up(username: "Fred", password: "test_password") }

      expect(page).to have_content "Username has already been taken"
    end

    it "keeps inputted username if error" do
      sign_up(username: "Fred")

      expect(page).to have_field('Username', :with => 'Fred')
    end
  end
end

feature "logging in" do
  before :each do
    sign_up(username: "Fred", password: "test_password")
  end

  it "shows sign out link and username on the homepage after login" do
    sign_in(username: "Fred", password: "test_password")

    expect(page).to have_content "Fred"
    expect(page).to have_content "Sign Out"
  end

  it "displays an error if password is wrong" do
    sign_in(username: "Fred", password: "test")

    expect(page).to have_content "Username or password is wrong"
  end

  it "displays an error if no username is provided" do
    sign_in(password: "test_password")

    expect(page).to have_content "Username or password is wrong"
  end

  it "displays an error if username does not exist" do
    sign_in(username: "Nancy", password: "test_password")

    expect(page).to have_content "Username or password is wrong"
  end
end

feature "logging out" do
  it "begins with logged out state" do
    visit "/"

    expect(page).to have_content "Sign In"
  end

  it "shows sign in link and doesn't show username on the homepage after logout" do
    sign_up(username: "Fred", password: "test_password")

    click_button "Sign Out"

    expect(page).to_not have_content "Fred"
    expect(page).to have_content "Sign In"

    visit "/"
  end
end
