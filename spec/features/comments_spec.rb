require 'spec_helper'
require 'rails_helper'
require 'byebug'

feature 'create a comment on a user' do
  before :each do
    sign_up(username: 'Fred', password: 'test_password')
    fred_id = User.find_by(username: 'Fred').id
    click_button "Sign Out"

    sign_up(username: 'George', password: 'george_password')
    visit "/users/#{fred_id}"
  end

  it "shows a form to make a comment" do
    expect(page).to have_field "Comment"
    expect(page).to have_button "Submit Comment"
  end


  it "can create a comment" do
    fill_in "Comment", with: "Example Comment"
    click_button "Submit Comment"
    expect(page).to have_content "Example Comment"
    expect(page).to have_content "George"
  end


  it "displays error if comment is blank" do
    click_button "Submit Comment"
    expect(page).to have_content "Reply can't be blank"
  end
end

feature 'create a comment on a goal' do
  before :each do
    sign_up(username: 'George', password: 'george_password')
    add_goal(body: "Hello World", public: true)
    goal_id = Goal.find_by(body: "Hello World").id
    visit "/goals/#{goal_id}"
  end


  it "shows a form to make a comment" do
    expect(page).to have_field "Comment"
    expect(page).to have_button "Submit Comment"
  end

  it "can create a comment" do
    fill_in "Comment", with: "Example Comment"
    click_button "Submit Comment"
    expect(page).to have_content "Example Comment"
    expect(page).to have_content "George"
  end

  it "displays error if comment is blank" do
    click_button "Submit Comment"
    expect(page).to have_content "Reply can't be blank"
  end
end
