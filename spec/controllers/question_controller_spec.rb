require 'spec_helper'
require 'rails_helper'

describe QuestionController do
  describe 'Logged in user' do
    before :each do
      ApplicationController.any_instance.stub(:authenticate)
      ApplicationController.any_instance.stub(:only_student)
    end
    describe 'adding question' do
      describe 'to existing office hour' do
        before :each do
          @fake_id = double('fake_id')
          @fake_instructor_id = double('fake_inst')
          @fake_course_id = double('fake_course')
          @fake_session_id = double('fake_session')
          @fake_question_text = double('fake_text')
          @fake_params = {question: @fake_question_text, course_id: @fake_course_id, office_hours_session_id: @fake_session_id, current_user: 1}
          @fake_question = {current_user: @fake_student_id, instructor_id: @fake_instructor_id, office_hours_session_id: @fake_session_id, course_id: @fake_course_id}
          allow(OfficeHoursSession).to receive(:exists?).and_return(true)
        end
        it 'should render the new question template' do
          oh = OfficeHoursSession.create(id: 0, course_id: 0, start_time: Time.current)
          allow(OfficeHoursSession).to receive(:find).with("0").and_return(oh)
          get :new, params: { office_hours_session_id: 0 }
          expect(response).to render_template('question/new')
        end
        it 'should make the users variable available to the template' do
          fake_user = double('fake_user')
          oh = OfficeHoursSession.create(id: 0, course_id: 0, start_time: Time.current)
          allow(OfficeHoursSession).to receive(:find).with("0").and_return(oh)
          allow(User).to receive(:all).and_return(fake_user)
          get :new, params: { office_hours_session_id: 0 }
          expect(assigns(:users)).to eq(fake_user)
        end
        it 'should call the model method add question on create' do
          expect(Question).to receive(:add_question!) {@fake_params}
          allow(@current_user).to receive(:id).and_return(1)
          post :create, params: @fake_params
        end
        it 'should give a warning notice if the question text is empty' do
          @fake_params_1 = {question: '', course_id: @fake_course_id, office_hours_session_id: @fake_session_id, current_user: 1}
          post :create, params: @fake_params_1
          expect(flash[:warning]).to match('Question can not be empty')
        end
        it 'should show a warning notice if the user tries to enter a second question' do
          oh = OfficeHoursSession.create(id: 0, course_id: 0, start_time: Time.current)
          allow(OfficeHoursSession).to receive(:find).with("0").and_return(oh)
          allow(@current_user).to receive(:id).and_return(1)
          q = Question.create(question_text: 'this is a question', time_added: Time.current, student_id: 1, office_hours_session_id: 0)
          allow(oh).to receive(:questions).and_return(Array(q))
          get :new, params: {office_hours_session_id: 0}
          expect(flash[:warning]).to match('User cannot add multiple questions to same queue')
        end
      end
      describe 'to a nonexisting office hour' do
        it 'should redirect to the home page' do
          allow(OfficeHoursSession).to receive(:exists?).and_return(false)
          get :new, params: {office_hours_session_id: 0}
          expect(response).to redirect_to(home_path)
        end
      end
    end

    describe 'deleting question' do
      before :each do
        @fake_id = double('fake_id')
        @fake_instructor_id = double('fake_inst')
        @fake_course_id = double('fake_course')
        @fake_session_id = double('fake_session')
        @fake_question_text = double('fake_text')
        @fake_params = {question_text: @fake_question_text, course_id: @fake_course_id, office_hours_session_id: @fake_session_id, current_user: 1}
        @fake_question = {current_user: @fake_student_id, instructor_id: @fake_instructor_id, office_hours_session_id: @fake_session_id, course_id: @fake_course_id}
      end
      it 'should give a flash message if the question was deleted' do
        @fake_q = Question.create(question_text: 'this was a question', time_added: Time.current)
        @fake_q.office_hours_session_id = 0
        allow(Question).to receive(:find).with(@fake_id.to_s).and_return(@fake_q)
        post :destroy, {params: {id: @fake_id, office_hours_session_id: 0}}
        expect(flash[:notice]).to match('Question was deleted.')
      end
      describe 'question does not exist' do
        it 'should raise an error if the question doesn\'t exist' do
          expect(Question).to receive(:find).with(@fake_id.to_s).and_raise(ActiveRecord::RecordNotFound)
          post :destroy, {params: {id: @fake_id, office_hours_session_id: 0}}
          expect(flash[:warning]).to match('Question does not exist.')
        end
        it 'should redirect to an office hours session if the office hours session exists' do
          allow(Question).to receive(:find).with(@fake_id.to_s).and_raise(ActiveRecord::RecordNotFound)
          allow(OfficeHoursSession).to receive(:exists?).and_return(true)
          post :destroy, {params: {id: @fake_id, office_hours_session_id: 0}}
          response.should redirect_to(office_hours_session_path(0))
        end
        it 'should redirect to the home page if the office hours sessions doesn\'t exist' do
          allow(Question).to receive(:find).with(@fake_id.to_s).and_raise(ActiveRecord::RecordNotFound)
          allow(OfficeHoursSession).to receive(:exists?).and_return(false)
          post :destroy, {params: {id: @fake_id, office_hours_session_id: 5}}
          response.should redirect_to(home_path)
        end
      end
    end
  end
  describe 'User not logged in' do
      before :each do
        @fake_id = double('fake_id')
        @fake_instructor_id = double('fake_inst')
        @fake_course_id = double('fake_course')
        @fake_session_id = double('fake_session')
        @fake_question_text = double('fake_text')
        @fake_params = {question: @fake_question_text, course_id: @fake_course_id, office_hours_session_id: @fake_session_id, current_user: 1}
        @fake_question = {current_user: @fake_student_id, instructor_id: @fake_instructor_id, office_hours_session_id: @fake_session_id, course_id: @fake_course_id}
        allow(OfficeHoursSession).to receive(:exists?).and_return(true)
      end
      it 'should render the new question template' do
        oh = OfficeHoursSession.create(id: 0, course_id: 0, start_time: Time.current)
        allow(OfficeHoursSession).to receive(:find).with("0").and_return(oh)
        get :new, params: { office_hours_session_id: 0 }
        expect(response).to redirect_to(root_path)
      end
    end
end
