require 'spec_helper'
require 'rails_helper'

describe HomeController do
  describe 'User logged in' do
    before :each do
      ApplicationController.any_instance.stub(:authenticate)
    end
    describe 'show action' do
      it 'should render the show template' do
        get :show
        expect(response).to render_template('show')
      end
      it 'should make the role variable available to the template' do
        role = create(:role, id: 3, role_name: 'ta')
        allow(Role).to receive(:find).and_return(role)
        allow(@current_user).to receive(:role_id).and_return(3)
        get :index
        expect(assigns(:role)).to eq(role)
      end
      it 'should make the oh button visible if the user is admin' do
        role = create(:role, id: 3, role_name: 'ta')
        allow(Role).to receive(:find).and_return(role)
        allow(@current_user).to receive(:role_id).and_return(role.id)
        allow(%w[admin professor]).to receive(:include?).and_return(true)
        get :index
        expect(assigns(:oh_button)).to eq(true)
      end
      it 'should make the office hours available to the template' do
        role = create(:role, id: 3, role_name: 'ta')
        allow(Role).to receive(:find).and_return(role)
        allow(@current_user).to receive(:role_id).and_return(role.id)
        fake_oh = double('fake_oh')
        allow(OfficeHoursSession).to receive(:all).and_return(fake_oh)
        get :index
        expect(assigns(:office_hours)).to eq(fake_oh)
      end
      it 'should show the admin button if user is admin' do
        role = create(:role, id: 2, role_name: 'professor')
        allow(Role).to receive(:find).and_return(role)
        allow(@current_user).to receive(:role_id).and_return(role.id)
        get :index
        expect(assigns(:admin_button)).to eq(true)
      end
    end
    describe 'join queue' do
      it 'should redirect to home path if queue id is blank' do
        post :join_queue, params: {queue_id: ''}
        expect(response).to redirect_to(home_path)
      end
      it 'should redirect to the office hours path if the session exists' do
        create(:course, id: 1)
        oh = create(:office_hours_session, id: 1, course_id: 1)
        allow(OfficeHoursSession).to receive(:find_by).and_return(oh)
        post :join_queue, params: {queue_id: 1}
        expect(response).to redirect_to(office_hours_session_path(oh.id))
      end
      it 'should redirect to the home path if the session doesn\'t exist' do
        expect(OfficeHoursSession).to receive(:find_by).and_raise(ActiveRecord::RecordNotFound)
        post :join_queue, params: {queue_id: 1}
        expect(response).to redirect_to(home_path)
      end
    end
  end
  describe 'User not logged in' do
    describe 'Going to home page' do
      it 'should redirect to root path if user not signed in' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
