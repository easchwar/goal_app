require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit(new_user_url)
    expect(page).to have_content("New User")
  end

  feature "signing up a user" do
    before(:each) do
      sign_up_as_test_user
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content('test_username')
    end

  end

end

feature "logging in" do
  before(:each) do
    sign_up_as_test_user
    click_on "Log Out"
    sign_in("test_username")
  end

  it "shows username on the homepage after login" do
    expect(page).to have_content('test_username')
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit new_session_url
    expect(page).to_not have_content('test_username')
  end

  it "doesn't show username on the homepage after logout" do
    sign_up_as_test_user
    click_on "Log Out"
    expect(page).to_not have_content('test_username')
  end
end

feature "must be logged in to view site content" do
  before(:each) do
    sign_up_as_test_user
    click_on 'Log Out'
  end

  it 'redirects to login page if non-logged in user attempts to visit site' do
    visit user_url(1)
    expect(page).to have_content('Sign In')
  end
end
