Given /^The following roles exist$/ do |roles_table|
  roles_table.hashes.each do |role|
    create(:role, id: role[:id], role_name: role[:role_name])
  end
end

Given /^I am logged in as student "(.*?)"$/ do |id|
  ApplicationController.any_instance.stub(:authenticate)
  create(:user, id: id)
  @current_user.stub(:id).and_return(id)
  @current_user.stub(:role_id).and_return(4)
end

Given /^Course "(.*?)" exists$/ do |course_name|
  create(:course, course_name: course_name)
end

Given /^Office hours session "(.*?)" exists$/ do |session_id|
  create(:office_hours_session, id: session_id)
end

Given /^I am on the new question page$/ do
  visit '/office_hours_session/0/question/new'
end

When /^I add the question "(.*?)"$/ do |question|
  fill_in 'question', :with => question
  @current_user.stub(:id).and_return(1)
  @current_user.stub(:role_id).and_return(4)
  click_button 'Ask'
end

Then /^I should see the question "(.*?)"$/ do |question|
  expect(page).to have_content(question)
end

Then /^I should see the flash message "(.*?)"$/ do |message|
  expect(page).to have_content(message)
end

Given /^I added the question "(.*?)"$/ do |question|
  visit '/office_hours_session/0/question/new'
  fill_in 'question', :with => question
  @current_user.stub(:id).and_return(1)
  @current_user.stub(:role_id).and_return(4)
  click_button 'Ask'
end

When /^I click on the button "(.*?)"\z$/ do |button_name|
  click_on(button_name)
end

Given /^I am on the office hours page$/ do
  visit '/office_hours_session/0'
end

Given /^The ta is on the office hours page$/ do
  @current_user.stub(:id).and_return(100)
  @current_user.stub(:role_id).and_return(3)
  visit '/office_hours_session/0'
end

Given /^The student with id "(.*?)" is on the office hours page$/ do |id|
  @current_user.stub(:id).and_return(id)
  @current_user.stub(:role_id).and_return(3)
  visit '/office_hours_session/0'
end

Then /^I should not see my question "(.*?)"$/ do |question|
  expect(page).should have_no_content(question)
end

Then /^I should not see the question "(.*?)"$/ do |question|
  expect(page).should have_no_content(question)
end

Given /^Student "(.*?)" added the question "(.*?)"$/ do |student_id, question|
  visit '/office_hours_session/0/question/new'
  fill_in 'question', :with => question
  @current_user.stub(:id).and_return(student_id)
  @current_user.stub(:role_id).and_return(4)
  click_button 'Ask'
end

Given /^Student "(.*?)" exists$/ do |id|
  create(:user, id: id)
end

Then /^I should not see the button "(.*?)"$/ do |button_name|
  expect(page).should have_no_content(button_name)
end

Given /^The following questions exist$/ do |questions_table|
  questions_table.hashes.each do |q|
    create(:question, id: q[:id], student_id: q[:student_id], question_text: q[:question_text])
  end
end

Given /^The following students exist$/ do |student_table|
  student_table.hashes.each do |id|
    create(:user, id: id, role_id: 4)
  end
end

Given /^I am logged in as a ta$/ do
  ApplicationController.any_instance.stub(:authenticate)
  create(:user, id: 100, role_id: 3)
end

Then /^I should see the remove button on each question$/ do
  num_questions = Question.all
  num_remove_buttons = 0
  num_questions.each do |q|
    if page.has_css?("#remove_#{q.id}")
      num_remove_buttons += 1
    end
  end
  expect(num_questions.count).to eq(num_remove_buttons)
end

When /^I click on the remove button on question "(.*?)"$/ do |id|
  click_on("remove_#{id}")
end

Given /^User "(.*?)" is on the home page$/ do |user_id|
  allow(ApplicationController).to receive(:current_user).and_return(User.find(user_id))
  @office_hours = OfficeHoursSession.all
  @current_user.stub(:role_id).and_return(3)
  @current_user.stub(:role_name).and_return('ta')
  HomeController.instance_variable_set(:@office_hours, OfficeHoursSession.all)
  visit home_path
end

Then /^I should see the button "(.*?)"$/ do |button_name|
  expect(page).to have_content(button_name)
end

Then /^I should see the input tag "(.*?)"$/ do |tag_name|
  page.should have_css("##{tag_name}")
end

Then /^I should not see the input tag "(.*?)"$/ do |tag_name|
  page.should have_css("##{tag_name}")
end
