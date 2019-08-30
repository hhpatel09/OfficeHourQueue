require 'spec_helper'
require 'rails_helper'

describe User do
  describe 'getting editable roles' do
    it 'should call the role method get editable roles' do
      fake_id = double('fake_id')
      expect(Role).to receive(:get_editable_roles).with(fake_id)
      User.get_editable_users(fake_id)
    end
  end
  describe 'updating role' do
    it 'should update a users role' do
      create(:role, id: 4)
      create(:role, id: 2)
      user = create(:user, id: 1, role_id: 4)
      allow(User).to receive(:find).with(1).and_return(user)
      User.update_role!(1,2)
      expect(user.role_id).to eql(2)
    end
  end
end
