require 'spec_helper'
require 'rails_helper'

describe OfficeHoursSession do
  it 'should throw an error if there isn\'t a course' do
    oh = OfficeHoursSession.new(start_time: Time.current)
    oh.valid?
    oh.errors[:course].should include('must exist')
  end
  it 'should throw an error if there isn\'t a start time' do
    oh = OfficeHoursSession.new(course_id: 1)
    oh.valid?
    oh.errors[:start_time].should include('can\'t be blank')
  end
end
