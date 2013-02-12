require 'spec_helper'

feature 'Key Management' do
  scenario 'Create key to sign up' do
    visit root_path

    expect(page).to have_content('Create a Key')

    fill_in 'passphrase', :with => 'this is my secret'
    click_button 'Generate Key'

    wait_forever do
      expect(page).to have_content('Download Private Key')
    end

    click_link 'Done'
    expect(page).to be_unlocked
  end

  scenario 'Upload key to sign up' do
    visit root_path
    expect(page).to have_content('Load existing key')

    click_link 'Load existing key'
    attach_file 'key', 'spec/fixtures/priv.pem'
    fill_in 'passphrase', :with => 'testing'
    click_button 'Unlock'
    expect(page).to be_unlocked

    # Ensure item creation works with loaded key
    create_item :title => 'Loaded Key'
    expect(page).to have_content('Loaded Key')
  end

  scenario 'Unlocking key' do
    generate_key
    visit root_path
    unlock_key
    expect(page).to be_unlocked
  end

  scenario 'Failing to unlock key' do
    generate_key
    visit root_path

    unlock_key 'wrong passphrase'
    expect(page).to have_content('Your passphrase was incorrect!')

    unlock_key
    expect(page).to be_unlocked
  end

  scenario 'Locking key' do
    generate_key
    visit root_path
    unlock_key

    click_link 'Lock'

    expect(page).to have_content('Unlock')
  end
end
