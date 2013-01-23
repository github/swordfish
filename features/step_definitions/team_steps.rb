Given 'I create a team named "$name"' do |name|
  click_link 'New Team'
  page.should have_content('Create a New Team')
  fill_in 'Name', :with => name
  click_button 'Create'
  page.should have_content(name)
end
