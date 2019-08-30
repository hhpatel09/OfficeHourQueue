Feature: Allow ta to make office hours session

  As a ta, I want to be able to create a new office hours
  session so that I can accept students questions

  Background:
    Given The following roles exist
      | id               | role_name  |
      | 1                | admin      |
      | 2                | professor  |
      | 3                | ta         |
      | 4                | student    |
    Given Course "SELT" exists
    Given Office hours session "0" exists

  Scenario:  Add an office hours session as a ta
    Given I am logged in as a ta
    And User "100" is on the home page
    Then I should see the input tag "new_office_hour"

  Scenario: Try to add an office hours session as a student
    Given I am logged in as student "1"
    And User "1" is on the home page
    Then I should not see the input tag "new_office_hour"

