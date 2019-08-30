Feature: Allow student to delete themselves from the queue

  As a student, I want to be able to delete myself
  from the queue so that I can leave the office hour

  Background:
    Given The following roles exist
      | id               | role_name  |
      | 1                | admin      |
      | 2                | professor  |
      | 3                | ta         |
      | 4                | student    |
    Given I am logged in as student "1"
    Given Student "2" exists
    Given Course "SELT" exists
    Given Office hours session "0" exists

  Scenario: Delete my own question
    Given I added the question "Is this my own question?"
    And I am on the office hours page
    Then I should see the question "Is this my own question?"
    When I click on the remove button on question "1"
    Then I should not see my question "Is this my own question?"

  Scenario: Try to delete someone else's question
    Given Student "2" added the question "This is my question!"
    And I am on the office hours page
    Then I should not see the button "remove"
