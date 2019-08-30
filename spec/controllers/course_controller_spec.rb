require 'spec_helper'
require 'rails_helper'

describe CourseController do
  describe 'User logged in' do
    before :each do
      ApplicationController.any_instance.stub(:authenticate)
    end
    describe 'show the courses' do
      it 'should redirect to course index path if the course id is invalid' do
        allow(Course).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)
        get :show, params: {id: 1}
        expect(response).to redirect_to(course_index_path)
      end
      it 'should show a flash message for an invalid course id' do
        allow(Course).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)
        get :show, params: {id: 1}
        expect(flash[:warning]).to match('Invalid Course')
        end
    end
    describe 'destroying a course' do
      it 'should show a flash message if the course is deleted' do
        course = create(:course, id: 1)
        allow(Course).to receive(:exists?).and_return(true)
        allow(Course).to receive(:find).and_return(course)
        get :destroy, params: {id: 1}
        expect(flash[:notice]).to match("Course #{course.course_name} was removed")
      end
    end
    describe 'edit course' do
      it 'should give a flash message if the course id is invalid' do
        allow(Course).to receive(:find).with("1").and_raise(ActiveRecord::RecordNotFound)
        get :edit, params: {id: 1}
        expect(flash[:warning]).to match('Invalid Course')
      end
      it 'should set the course variable if the course exists' do
        course = create(:course)
        allow(Course).to receive(:find).with("1").and_return(course)
        get :edit, params: {id: 1}
        expect(assigns(:course)).to eql(course)
      end
    end
    describe 'showing the index page' do
      it 'should set the courses variable' do
        course = create(:course)
        allow(Course).to receive(:all).and_return(course)
        get :index
        expect(assigns(:courses)).to eql(course)
      end
    end
    describe 'updating the course' do
      it 'should give a flash message if the user doesn\'t have permission to edit courses' do
        role = create(:role, id: 4)
        create(:course, id: 1)
        allow(@current_user).to receive(:role_id).and_return(4)
        allow(Role).to receive(:find).with(4).and_return(role)
        allow(role).to receive(:role_name).and_return('student')
        get :update, params: {id: 1}
        expect(flash[:warning]).to match("Don't have permission to edit course")
      end
      it 'should give a flash message if the parameters aren\'t valid and the user has permission' do
        role = create(:role, id: 2)
        create(:course, id: 1)
        allow(@current_user).to receive(:role_id).and_return(2)
        allow(Role).to receive(:find).with(2).and_return(role)
        allow(role).to receive(:role_name).and_return('professor')
        get :update, params: {id: 1}
        expect(flash[:warning]).to match("One or more of the fields is incorrect")
      end
      it 'should give a flash message if the course gets updated' do
        role = create(:role, id: 2)
        c = create(:course, id: 1)
        allow(@current_user).to receive(:role_id).and_return(2)
        allow(Role).to receive(:find).with(2).and_return(role)
        allow(role).to receive(:role_name).and_return('professor')
        CourseController.any_instance.stub(:valid_params).and_return(true)
        get :update, params: {id: 1}
        expect(flash[:notice]).to match("The course #{c.course_name} has been successfully updated")
      end
    end
    describe 'creating a new course' do
      it 'should give a flash message if the user doesn\'t have permission to create courses' do
        role = create(:role, id: 4)
        create(:course, id: 1)
        allow(@current_user).to receive(:role_id).and_return(4)
        allow(Role).to receive(:find).with(4).and_return(role)
        allow(role).to receive(:role_name).and_return('student')
        get :create, params: {id: 1}
        expect(flash[:warning]).to match("Don't have permission to create course")
      end
      it 'should give a flash message if the parameters aren\'t valid and the user has permission' do
        role = create(:role, id: 2)
        create(:course, id: 1)
        allow(@current_user).to receive(:role_id).and_return(2)
        allow(Role).to receive(:find).with(2).and_return(role)
        allow(role).to receive(:role_name).and_return('professor')
        get :create, params: {id: 1}
        expect(flash[:warning]).to match("One or more of the fields is incorrect")
      end
      it 'should give a flash message if the course gets create' do
        role = create(:role, id: 2)
        c = create(:course, id: 1)
        fake_params = {department_name: 'ECE', course_number: '5280', course_name: 'SELT', semester: 'fall2018'}
        allow(@current_user).to receive(:role_id).and_return(2)
        allow(Role).to receive(:find).with(2).and_return(role)
        allow(role).to receive(:role_name).and_return('professor')
        CourseController.any_instance.stub(:course_params).and_return(fake_params)
        CourseController.any_instance.stub(:valid_params).and_return(true)
        get :create, params: {id: 1}
        expect(flash[:notice]).to match("The course #{c.course_name} has been successfully added")
      end
    end
  end
end

