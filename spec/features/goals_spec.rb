require 'spec_helper'
require 'rails_helper'

feature 'create a goal' do
  before :each do
    sign_up(username: 'Fred', password: 'test_password')
    sign_in(username: 'Fred', password: 'test_password')
  end

  it 'redirects to sign in page if not signed in' do
    click_button "Sign Out"

    visit "/goals/new"
    expect(page).to have_button "Sign In"
  end

  it 'there is a link to create goals' do
    expect(page).to have_content "Add Goal"
  end

  it 'show goal text after creation' do
    add_goal(body: "Goal body test", private: true)
    expect(page).to have_content "Goal body test"
  end

  it 'show whether is private after creation' do
    add_goal(body: "Goal body test", private: true)
    expect(page).to have_content "Private"
  end

  it 'shows error if no goal text provided' do
    add_goal(private: true)
    expect(page).to have_content "Body can't be blank"
  end

  it 'shows error if neither private nor public selected' do
    add_goal(body: "Goal body test")
    expect(page).to have_content "must be selected"
  end
end

feature 'read a goal' do

end

feature 'update a goal' do
end

feature 'delete  a goal' do
end
