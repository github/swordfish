require 'spec_helper'

feature 'Items' do
  before(:each) do
    generate_key
    visit root_path
    unlock_key
  end

  scenario 'creating and editing an item' do
    click_link 'New Item'
    fill_in "Title",    :with => "example.com"
    fill_in "Username", :with => "myusername"
    fill_in "Password", :with => "mypassword"
    fill_in "Confirm",  :with => "mypassword"
    click_button "Create"

    within('#items') { expect(page).to have_content('example.com') }

    visit root_path
    unlock_key
    expect(page).to have_content("example.com")
    click_link "example.com"
    expect(page).to have_content("myusername")

    click_link "reveal"
    expect(page).to have_content("mypassword")
    click_link "hide"
    expect(page).to have_no_content("mypassword")

    click_link "Edit"
    expect(find_field("Title").value).to eql("example.com")
    expect(find_field("Username").value).to eql("myusername")
    expect(find_field("Password").value).to eql("mypassword")
    expect(find_field("Confirm").value).to eql("mypassword")

    fill_in "Title", :with => "Example"
    fill_in "Username", :with => "updated-username"
    click_button "Save"

    within('#items') { expect(page).to have_content('Example') }
    expect(page).to have_content("updated-username")
  end

  scenario 'mismatching password confirmation' do
    click_link "+"
    fill_in "Title", :with => "example.com"
    fill_in "Username", :with => "myusername"
    fill_in "Password", :with => "mypassword"
    click_button "Create"
    expect(page).to have_no_content('example.com')

    fill_in "Password", :with => ""
    fill_in "Confirm", :with => "mypassword"
    click_button "Create"
    expect(page).to have_no_content('example.com')
  end

  scenario 'requires matching passwords on update' do
    create_item

    click_link 'Edit'
    fill_in "Password", :with => "newpassword"
    click_button "Save"
    expect(page).to have_content('Save')

    fill_in "Confirm", :with => "newpassword"
    click_button "Save"
    click_link "reveal"
    expect(page).to have_content("newpassword")
  end
end
