require 'rails_helper'

feature 'comments for users' do
  before(:each) do
    sign_up_as_test_user
    click_on 'Log Out'
    sign_up('foo')
  end

  it 'users can comment on other users' do
    visit user_url(User.find_by_username('test_username'))
    expect(page).to have_selector(:link_or_button, 'Add Comment')
  end

  it "adding a comment redirects to commented on user's show page" do
    visit user_url(User.find_by_username('test_username'))
    fill_in 'Comment', with: 'hi'
    click_on 'Add Comment'
    expect(page).to have_content('test_username')
  end

  it "comments are displayed on user's show page" do
    visit user_url(User.find_by_username('test_username'))
    fill_in 'Comment', with: 'hello test_username'
    click_on 'Add Comment'
    expect(page).to have_content('hello test_username')
  end

  it 'adding a blank comment redirects to user show page' do
    visit user_url(User.find_by_username('test_username'))
    click_on 'Add Comment'
    expect(page).to have_content('test_username')
    expect(page).to have_content("Comment can't be blank")
  end

  feature 'removing comments' do
    before(:each) do
      visit user_url(User.find_by_username('test_username'))
      fill_in 'Comment', with: 'hi'
      click_on 'Add Comment'
    end

    it "author should be able to remove comment" do
      expect(page).to have_selector(:link_or_button, 'Remove Comment')
    end

    it "commented on user should be able to remove comment" do
      click_on 'Log Out'
      sign_in('test_username')
      expect(page).to have_selector(:link_or_button, 'Remove Comment')
    end

    it "other users should not be able to remove comment" do
      click_on 'Log Out'
      sign_up('bar')
      visit user_url(User.find_by_username('test_username'))
      expect(page).to_not have_selector(:link_or_button, 'Remove Comment')
    end
  end
end

feature 'comments for goals' do
  before(:each) do
    sign_up_as_test_user
    make_goal('test_goal', 'public')
    click_on 'Log Out'
    sign_up('foo')
  end

  it "users can comment on other users' goals" do
    visit goal_url(Goal.find_by_name('test_goal'))
    expect(page).to have_selector(:link_or_button, 'Add Comment')
  end

  it "adding a comment redirects to commented on goal's show page" do
    visit goal_url(Goal.find_by_name('test_goal'))
    fill_in 'Comment', with: 'hi'
    click_on 'Add Comment'
    expect(page).to have_content('test_goal')
    expect(page).to have_content('Status: in progress')
  end

  it "comments are displayed on goal's show page" do
    visit goal_url(Goal.find_by_name('test_goal'))
    fill_in 'Comment', with: "hello test_username's goal"
    click_on 'Add Comment'
    expect(page).to have_content("hello test_username's goal")
  end

  it 'adding a blank comment redirects to goal show page' do
    visit goal_url(Goal.find_by_name('test_goal'))
    click_on 'Add Comment'
    expect(page).to have_content('Status: in progress')
    expect(page).to have_content("Comment can't be blank")
  end

  feature 'removing comments' do
    before(:each) do
      visit goal_url(Goal.find_by_name('test_goal'))
      fill_in 'Comment', with: 'hi'
      click_on 'Add Comment'
    end

    it "author should be able to remove comment" do
      expect(page).to have_selector(:link_or_button, 'Remove Comment')
    end

    it "commented on goal's user should be able to remove comment" do
      click_on 'Log Out'
      sign_in('test_username')
      visit goal_url(Goal.find_by_name('test_goal'))
      expect(page).to have_selector(:link_or_button, 'Remove Comment')
    end

    it "other users should not be able to remove comment" do
      click_on 'Log Out'
      sign_up('bar')
      visit goal_url(Goal.find_by_name('test_goal'))
      expect(page).to_not have_selector(:link_or_button, 'Remove Comment')
    end
  end
end
