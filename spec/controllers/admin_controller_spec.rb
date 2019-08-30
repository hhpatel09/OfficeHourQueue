require 'spec_helper'
require 'rails_helper'

describe AdminController do
  describe 'Logged in user' do
    before :each do
      ApplicationController.any_instance.stub(:authenticate)
    end
    describe 'Index page' do
      before :each do
        @fake_role = create(:role, id: 1, role_name: 'admin')
        @fake_users = create(:user, id: 1, role_id: 1)
        allow(User).to receive(:find_by).and_return(@fake_users)
      end
      it 'should call the get editable user method' do
        expect(User).to receive(:get_editable_users).with(1)
        allow(User).to receive(:find_by).and_return(@fake_users)
        get :index
      end
      it 'should make users available to the template' do
        allow(User).to receive(:get_editable_users).with(1).and_return(@fake_users)
        get :index
        expect(assigns(:users)).to eql(@fake_users)
      end
    end
    describe 'editing permissions' do
      before :each do
        create(:role, id: 1, role_name: 'admin')
        create(:role, id: 2, role_name: 'instructor')
        create(:role, id: 3, role_name: 'ta')
        create(:role, id: 4, role_name: 'student')
      end
      it 'should give a flash message if the user can\'t edit permissions' do
        student = create(:user, id: 1, role_id: 4)
        allow(User).to receive(:find_by).and_return(student)
        allow(User).to receive(:permission_to_edit?).and_return(false)
        get :edit, params: {id: 1}
        expect(flash[:warning]).to match("You don't have permissions to edit this user")
      end
      it 'should give a flash method if the user doesn\'t exist' do
        ta = create(:user, id: 1, role_id: 3)
        allow(User).to receive(:find_by).and_return(ta)
        allow(User).to receive(:permission_to_edit?).and_return(true)
        allow(User).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :edit, params: {id: 1}
        expect(flash[:warning]).to match('Invalid User')
      end
    end
    describe 'updating user permissions' do
      before :each do
        create(:role, id: 1, role_name: 'admin')
        create(:role, id: 2, role_name: 'instructor')
        create(:role, id: 3, role_name: 'ta')
        create(:role, id: 4, role_name: 'student')
      end
      it 'should give a flash method for invalid role ids' do
        post :update, params: {id: 1, role_id: 5}
        expect(flash[:warning]).to match("Invalid role_id. Not saving changes.")
      end
      it 'should give a flash method if user doesn\'t have permission to edit' do
        student = create(:user, id: 1, role_id: 4)
        allow(User).to receive(:find_by).and_return(student)
        post :update, params: {id: 1, role_id: 2}
        expect(flash[:warning]).to match("You don't have permissions to edit this user")
      end
      it 'should call the update role model method' do
        admin = create(:user, id: 1, role_id: 1)
        create(:user, id: 2, role_id: 4)
        allow(User).to receive(:find_by).and_return(admin)
        expect(User).to receive(:update_role!).with(2.to_s,3.to_s)
        post :update, params: {id: 2, role_id: 3}
      end
    end
  end
end
