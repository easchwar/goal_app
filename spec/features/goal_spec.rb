require 'rails_helper'

feature 'goal creation' do
  before(:each) do
    sign_up_as_test_user
  end

  it 'has a link to new goal url' do
    expect(page).to have_content('New Goal')
  end

  it 'new goal link directs to new goal url' do
    click_on('New Goal')
    expect(page).to have_content('New Goal')
  end

  it 'redirects to the goal show page after creation' do
    click_on('New Goal')
    fill_in 'Name', with: 'Finish App Academy'
    fill_in 'Description', with: "let's do it"
    choose 'public'
    click_on 'Create Goal'
    expect(page).to have_content('Finish App Academy')
  end

  it 're-renders template on unsuccessful create' do
    click_on 'New Goal'
    click_on 'Create Goal'
    expect(page).to have_content("Name can't be blank")
  end

  it 'new goal appears on user show page after creation' do
    click_on('New Goal')
    fill_in 'Name', with: 'Finish App Academy'
    fill_in 'Description', with: "let's do it"
    choose 'public'
    click_on 'Create Goal'
    visit user_url(User.first)
    expect(page).to have_content('Finish App Academy')
  end

end

feature 'showing all goals' do
  before(:each) do
    sign_up("foo")
    make_goal('private_goal', 'private')
    make_goal('public_goal', 'public')
    click_on 'Log Out'
    sign_up_as_test_user
  end

  it "should display other users' public goals" do
    expect(page).to have_content('public_goal')
  end

  it "should not display other users' private goals" do
    expect(page).to_not have_content('private_goal')
  end
end

feature 'editing goals' do
  before(:each) do
    sign_up_as_test_user
    make_goal('test_goal', 'public')
  end

  it 'allow user to edit own goals' do
    expect(page).to have_content('Edit Goal')
  end

  it 'redirects to goal show page after update' do
    click_on 'Edit Goal'
    fill_in 'Description', with: 'Updated!'
    click_on 'Update Goal'
    expect(page).to have_content('Updated!')
  end

  it 're-renders template on unsuccessful edit' do
    click_on 'Edit Goal'
    fill_in 'Name', with: ''
    click_on 'Update Goal'
    expect(page).to have_content("Name can't be blank")
  end

  it "doesn't allow user to edit other user's goals" do
    click_on 'Log Out'
    sign_up("foo")
    click_on 'test_goal'
    expect(page).to_not have_content('Edit Goal')
  end
end

feature 'deleting goals' do
  before(:each) do
    sign_up_as_test_user
    make_goal('test_goal', 'public')
  end

  it 'allow user to delete own goals' do
    expect(page).to have_selector(:link_or_button, 'Remove Goal')
  end

  it 'redirects to user show page after deletion' do
    click_on 'Remove Goal'
    expect(page).to_not have_content('test_goal')
  end

  it "doesn't allow user to delete other user's goals" do
    click_on 'Log Out'
    sign_up("foo")
    click_on 'test_goal'
    expect(page).to_not have_content('Remove Goal')
  end
end
