FactoryBot.define do
  factory :office_hours_session do
    id { 0 }
    course_id { 0 }
    start_time { Time.current }
    end
  end
