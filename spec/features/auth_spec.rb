require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do

  before :each do
    visit "/users/new"
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do


    it "shows username on the homepage after signup" do
      fill_in "Username", with: "Fred"
      fill_in "Password", with: "test_password"
      click_button "Sign Up"

      expect(page).to have_content "Fred"
    end

    it "displays an error if no password" do
      fill_in "Username", with: "Fred"
      click_button "Sign Up"

      expect(page).to have_content "Password is too short"
    end
    it "displays an error if password too short" do
      fill_in "Password", with: "test"
      click_button "Sign Up"

      expect(page).to have_content "Password is too short"
    end

    it "displays an error if no username" do
      fill_in "Password", with: "test_password"
      click_button "Sign Up"

      expect(page).to have_content "Username can't be blank"
    end

    it "displays an error if username not unique" do
      fill_in "Username", with: "Fred"
      fill_in "Password", with: "test_password"
      click_button "Sign Up"

      visit "/users/new"

      fill_in "Username", with: "Fred"
      fill_in "Password", with: "test_password"
      click_button "Sign Up"

      expect(page).to have_content "Username has already been taken"

    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login"

end

feature "logging out" do

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end
