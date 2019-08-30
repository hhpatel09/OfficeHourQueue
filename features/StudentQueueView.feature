Feature: Students should see only the question they've asked, not all questions in the queue

  Background:
    Given The following roles exist
      | id               | role_name  |
      | 1                | admin      |
      | 2                | professor  |
      | 3                | ta         |
      | 4                | student    |
    Given The following students exist
      | id |
      | 2  |
      | 3  |
      | 4  |
    Given The following questions exist
      | id | student_id | question_text         |
      | 2  | 2          | "This is question 2 " |
      | 3  | 3          | "This is question 3 " |

    Given I am logged in as student "5"
    Given Course "SELT" exists
    Given Office hours session "0" exists

  Scenario:  Should Not See Other Students' Questions
    Given I am on the office hours page
    Then I should not see the question "This is question 2"
    And I should not see the question "This is question 3"


  Scenario: Add a Question and Only See That One
    Given I am on the office hours page
    And I added the question "Is this my own question?"
    Then I should see the question "Is this my own question?"
    And I should not see the question "This is question 2"
    And I should not see the question "This is question 3"
