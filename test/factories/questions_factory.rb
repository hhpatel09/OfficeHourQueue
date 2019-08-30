FactoryBot.define do
  factory :question do
    id { 1 }
    question_text { 'this is question text' }
    student_id { 1 }
    instructor_id { 2 }
    course_id { 0 }
    office_hours_session_id { 0 }
    time_added { Time.current }
    end
  end
