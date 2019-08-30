require 'spec_helper'
require 'rails_helper'

describe Message do
  describe 'adding a message' do
    it 'should throw an error if there isn\'t a user' do
      create(:course, id: 1, department_name: 'ECE', course_number: '5280', course_name: 'SELT', semester: 'fall18')
      create(:office_hours_session, id: 0, course_id: 1)
      m = Message.new(message_text: 'this is a message', time: Time.current, office_hours_session_id: 0)
      m.valid?
      m.errors[:user].should include('must exist')
    end
    it 'should throw an error if there isn\'t an office hours session' do
      create(:role, id: 2)
      create(:user, id: 1, role_id: 2)
      m = Message.new(message_text: 'this is a message', time: Time.current, user_id: 1)
      m.valid?
      m.errors[:office_hours_session].should include('must exist')
    end
  end
end
