require 'spec_helper'

describe User do
  let(:user) { User.create! }

  describe 'add_vault' do
    let(:vault) { Vault.create!(:name => 'testing') }
    before do
      user.add_vault(vault)
    end

    it 'updates vaults in memory' do
      expect(user.vaults).to include(vault)
    end

    it 'updates vaults in db' do
      expect(user.reload.vaults).to include(vault)
    end
  end
end