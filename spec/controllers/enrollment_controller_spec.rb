require 'spec_helper'
require 'rails_helper'

describe EnrollmentController do
  before :each do
    ApplicationController.any_instance.stub(:authenticate)
  end
  describe 'adding an enrollment' do
    describe 'creating a enrollment' do
      it 'should create an enrollment' do
        course = create(:course)
        create(:role, id: 4)
        user = create(:user, id: 1, role_id: 4)
        user1 = create(:user, id: 2, role_id: 4)
        user2 = create(:user, id: 3, role_id: 4)
        allow(Course).to receive(:find).and_return(course)
        allow(Enrollment).to receive(:create!)
        user_list = {'1': user, '2': user1, '3': user2 }
        post :create, params: {id: 1, user_list: user_list}
        expect(Enrollment).to have_received(:create!).exactly(3).times
      end
    end
    describe 'edit enrollment' do
      it 'should set the enrollments variable' do
        create(:role, id: 4)
        create(:user, id: 1, role_id: 4)
        create(:course, id: 1)
        enrollment = create(:enrollment, user_id: 1, course_id: 1)
        Enrollment.stub_chain(:where,:select).and_return(Array(enrollment))
        get :edit, params: {id: 1}
        expect(assigns(:enrollments)).to eql(Array(enrollment))
      end
    end
    describe 'show enrollment' do
      it 'should set the enrollments variable' do
        create(:role, id: 4)
        create(:user, id: 1, role_id: 4)
        create(:course, id: 1)
        enrollment = create(:enrollment, user_id: 1, course_id: 1)
        Enrollment.stub_chain(:where,:select).and_return(Array(enrollment))
        get :show, params: {id: 1}
        expect(assigns(:enrollments)).to eql(Array(enrollment))
      end
    end
    describe 'new enrollment' do
      it 'should set the enrollment variable' do
        create(:role, id: 4)
        create(:user, id: 1, role_id: 4)
        create(:course, id: 1)
        enrollment = create(:enrollment, user_id: 1, course_id: 1)
        Enrollment.stub_chain(:where,:select).and_return(Array(enrollment))
        get :new, params: {id: 1}
        expect(assigns(:enrollments)).to eql(Array(enrollment))
      end
    end
  end
end
