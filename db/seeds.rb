# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
['admin','professor','ta','student'].each do |name|
  Role.create!({role_name: name})
end

course = Course.create!(department_name: 'ECE', course_number: '5820', course_name: 'SELT', semester: 'Fall2018')
if course.persisted?
  oh1 = course.office_hours_sessions.build(start_time: Time.current, uuid: 'ABC123')
  oh1.save!
end

student = User.create!(first_name: 'Claire', last_name: "O'Connell", email: 'imdying@uiowa.edu', role_id: 4, session_token: SecureRandom.base64)
student1 = User.create!(first_name: 'Cooper', last_name: 'Bell', email: 'simplytrivial@ez.edu', role_id: 4, session_token: SecureRandom.base64)
instructor = User.create!(first_name: 'Hans-y', last_name: 'Johnny', email: 'selt@uiowa.edu', role_id: 2, session_token: SecureRandom.base64)

# Enrollment.create!(users_id: 1, courses_id: 1)
# Enrollment.create!(users_id: 2, courses_id: 1)
arr = ['Tryna Date?', 'What do?', 'How many CVS receipts does it to get to the moon?']
arr.each do |each_question_to_put_in_db|
  q1 = Question.create(question_text: each_question_to_put_in_db, time_added: Time.current)
  q1.student_id = student1.id
  q1.instructor_id = instructor.id
  q1.office_hours_session_id = oh1.id
  q1.course_id = course.id
  q1.save!

end
q2 = Question.create(question_text: 'Why does Hawaii have interstates?', time_added: Time.current)
q2.student_id = student.id
q2.instructor_id = instructor.id
q2.office_hours_session_id = oh1.id
q2.course_id = course.id
q2.save!

# qs = oh1.questions.build(question_text: 'THIS IS A QUESTION', time_added: Time.current)
# qs.save!


