Feature: Users with permissions above student should see all questions in the queue

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
    Given The following questions exist
      | id | student_id | question_text         |
      | 1  | 1          | "This is question 1 " |
      | 2  | 2          | "This is question 2 " |
      | 3  | 3          | "This is question 3 " |

    Given I am logged in as a ta
    Given Course "SELT" exists
    Given Office hours session "0" exists

  Scenario:  Should See All Questions
    Given The ta is on the office hours page
    Then I should see the question "This is question 1"
    And I should see the question "This is question 2"
    And I should see the question "This is question 3"
