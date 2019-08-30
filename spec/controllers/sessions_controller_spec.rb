require 'spec_helper'
require 'rails_helper'
require 'capybara/rspec'

describe SessionsController do
  def setup
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  describe 'destroying a session' do
    it 'should redirect to the root path' do
      get :destroy
      expect(response).to redirect_to(root_path)
    end
  end
  before :each do
    @auth_hash = OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      'uid':'123545',
      'provider': 'google'
    })
    setup
  end
  describe 'creating a session' do
    it 'should call the find or create method' do
      create(:role, id: 1, role_name: 'admin')
      fake_user = create(:user, id: 1, role_id: 1)
      expect(User).to receive(:find_or_create_from_auth_hash).with(@auth_hash).and_return(fake_user)
      get :create, params: { provider: 'google' }
    end
  end
end

