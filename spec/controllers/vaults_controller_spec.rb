require 'spec_helper'

describe VaultsController do
  before do
    sign_in_as double(:user, :id => BSON::ObjectId, :add_vault => nil)
  end

  describe 'create' do
    it 'renders json' do
      post :create, :name => 'Honeypot', :key => 'abc123'
      json = JSON.parse(response.body)
      expect(json['name']).to eq('Honeypot')
      expect(json['key']).to eq('abc123')
    end
  end
end