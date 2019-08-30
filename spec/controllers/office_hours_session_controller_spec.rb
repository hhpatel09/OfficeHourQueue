require 'spec_helper'
require 'rails_helper'

describe OfficeHoursSessionController do
  describe 'User logged in' do
    before :each do
      ApplicationController.any_instance.stub(:authenticate)
    end
    describe 'rendering Office Hours Session page that exists' do
      before :each do
        @oh = OfficeHoursSession.create(id: 1, course_id: 1, start_time: Time.current)
        @c = Course.create(department_name: 'ECE', course_number: '5820', course_name: 'SELT', semester: 'Fall 2018')
        allow(OfficeHoursSession).to receive(:find).with("1").and_return(@oh)
        allow(OfficeHoursSession).to receive(:exists?).and_return(true)
        ta = create(:role, id: 3)
        student = create(:role, id: 4)
        allow(Role).to receive(:find_by_role_name).with('ta').and_return(ta)
        allow(Role).to receive(:find_by_role_name).with('student').and_return(student)
      end
      it 'should render office hours session page' do
        get :show, params: {:id => 1}
        expect(response).to render_template('office_hours_session/show')
      end
      it 'should set the questions variable' do
        fake_question = double('fake_q')
        allow(@oh).to receive(:questions).and_return(fake_question)
        get :show, params: {:id => 1}
        expect(assigns(:questions)).to eq(fake_question)
      end
      it 'should set the users variable' do
        fake_user = double('fake_user')
        allow(User).to receive(:all).and_return(fake_user)
        get :show, params: {:id => 1}
        expect(assigns(:users)).to eq(fake_user)
      end
      it 'should set the id variable' do
        get :show, params: {:id => 1}
        expect(assigns(:id)).to eq(1.to_s)
      end
    end
    describe 'Office hours session doesn\'t exist' do
      it 'should redirect to the home page' do
        allow(OfficeHoursSession).to receive(:exists?).and_return(false)
        get :show, params: {:id => 5}
        expect(response).to redirect_to(home_path)
      end
    end
    describe 'Creating a new office hours session' do
      before :each do
        @c = Course.create!(department_name: 'ECE', course_number: '5820', course_name: 'SELT', semester: 'fall2018')
        OfficeHoursSession.create!(id: 1, course_id: 1, start_time: Time.current)
      end
      it 'should redirect to the office hours session path' do
        allow(Course).to receive(:find_by).and_return(@c)
        get :create, params: {id: 1, course_id: 1}
        expect(response).to redirect_to(office_hours_session_path(2))
      end
    end
  end
  describe 'User not logged in' do
    before :each do
      @oh = OfficeHoursSession.create(id: 0, course_id: 0, start_time: Time.current)
      allow(OfficeHoursSession).to receive(:find).with("0").and_return(@oh)
      allow(OfficeHoursSession).to receive(:exists?).and_return(true)
      ta = create(:role, id: 3)
      student = create(:role, id: 4)
      allow(Role).to receive(:find_by_role_name).with('ta').and_return(ta)
      allow(Role).to receive(:find_by_role_name).with('student').and_return(student)
    end
    it 'should redirect to the root path' do
      get :show, params: {:id => 0}
      expect(response).to redirect_to(root_path)
    end
  end
end
