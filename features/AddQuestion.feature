Feature: Allow student to add themselves to queue

  As a student, I want to be able to add myself
  to the queue so that I can get my questions answered

  Background:
    Given The following roles exist
      | id               | role_name  |
      | 1                | admin      |
      | 2                | professor  |
      | 3                | ta         |
      | 4                | student    |
    Given I am logged in as student "1"
    Given Course "SELT" exists
    Given Office hours session "0" exists

  Scenario:  Add a question to queue
    Given I am on the new question page
    When I add the question "Why are questions a thing?"
    Then I should see the question "Why are questions a thing?"

  Scenario: Add an empty question
    Given I am on the new question page
    When I add the question ""
    Then I should see the flash message "Question can not be empty"

  Scenario: Adding multiple questions
    Given I added the question "Why are questions a thing"
    Then I should not see the button "add_question"
