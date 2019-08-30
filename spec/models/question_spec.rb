require 'spec_helper'
require 'rails_helper'

describe Question do
  describe 'adding question' do
    before :each do
      fake_student_id = double('fake_stud')
      fake_instructor_id = double('fake_inst')
      fake_course_id = double('fake_course')
      fake_session_id = double('fake_session')
      @fake_time = double('fake_time')
      @fake_q = double('fake_q')
      @fake_params = {:question_text => @fake_q, :current_user => fake_student_id, instructor_id: fake_instructor_id, course_id: fake_course_id, office_hours_session_id: fake_session_id}
      allow(@current_user).to receive(:id).and_return(1)
      allow(Time).to receive(:current).and_return(@fake_time)
    end
    it 'should call the create method' do
      q = Question.new(question_text: @fake_q, time_added: @fake_time)
      Question.any_instance.stub(:save!).and_return(true)
      expect(Question).to receive(:create).with(question_text: @fake_q, time_added: @fake_time).and_return(q)
      Question.add_question!(@fake_params)
    end
  end
end
