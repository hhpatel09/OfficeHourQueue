Feature: Allow ta to delete anyone from the queue

  As a ta, I want to be able to delete any question
  from the queue so that I can delete bad questions

  Background:
    Given The following roles exist
      | id               | role_name  |
      | 1                | admin      |
      | 2                | professor  |
      | 3                | ta         |
      | 4                | student    |
    Given The following students exist
      | id |
      | 1  |
      | 2  |
      | 3  |
      | 4  |
    Given The following questions exist
      | id | student_id | question_text         |
      | 1  | 1          | "This is my question" |
      | 2  | 2          | "This is question 2 " |
      | 3  | 3          | "This is question 3 " |


    Given I am logged in as a ta
    Given Course "SELT" exists
    Given Office hours session "0" exists

  Scenario: Delete any question
    Given The ta is on the office hours page
    Then I should see the remove button on each question

  Scenario: Delete any question
    Given The ta is on the office hours page
    When I click on the remove button on question "1"
    Then I should not see my question "This is my question"
    And I should see the question "This is question 2"
    And I should see the question "This is question 3"

