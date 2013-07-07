require 'spec_helper'

feature 'Teams' do
  before(:each) do
    generate_key
    visit root_path
    unlock_key
  end

  scenario 'creating and updating a team' do
    click_link 'New Team'
    fill_in 'Name', :with => 'GitHub'
    click_button 'Create'
    within('#sidebar') { expect(page).to have_content('GitHub') }
    within('#details') { expect(page).to have_content('GitHub') }

    within('#details') { click_link 'Edit' }

    fill_in 'Name', :with => 'GitHub Staff'
    click_button 'Save'
    within('#sidebar') { expect(page).to have_content('GitHub Staff') }
    within('#details') { expect(page).to have_content('GitHub Staff') }
  end

  pending 'adding a new user to a team' do
    create_team 'Name' => 'GitHub'
    click_link 'GitHub'
    fill_in "Email", :with => "shawn@example.com"
    click_button 'Invite'
    within('.memberships') { expect(page).to have_content('shawn@example.com') }

    sign_out

    open_email('shawn@example.com')
    click_first_link_in_email
    generate_key
    expect(page).to have_content('GitHub')
    expect(page).to have_content('waiting for Brandon Keepers to sign in')
  end
end
