# Author: Daniel Montecinos

@rm @meetings @functional @get @negative
Feature: GET /meetings

  Scenario: Try to retrieve all created meetings without set queries
    Given I make a 'GET' request to '/meetings'
    When I execute the request
    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name" : "ExchangeCalendarError",
            "description" : "Owner calendar query parameter shouldn't be undefined."
          }
        """

  Scenario Outline: Try to retrieve all created meetings setting
  the owner field with invalid emails
    Given I make a 'GET' request to '/meetings'
      And I set this queries:
        | owner | <owner>                  |
        | start | 2019-03-01T20:00:00.000Z |
        | end   | 2019-03-31T20:30:00.000Z |
    When I execute the request
    Then I expect a '404' status code
      And the JSON should be:
        """
          {
            "name" : "AccountNotFoundError",
            "description" : "The exchange account doesn't exist."
          }
        """
    Examples:
      | owner                            |
      | ""                               |
      | invalid_email                    |
      | fake_owner_email@arabitpro.local |
      | !@#$%^&*()                       |


  Scenario: Try to retrieve all created meetings setting the start
  field with an invalid date
    Given I make a 'GET' request to '/meetings'
    And I set this queries:
      | owner | RM@arabitpro.local       |
      | start | 209-03-31T20:30:00.000Z  |
      | end   | 2019-03-31T20:30:00.000Z |
    When I execute the request
    Then I expect a '400' status code
    And the JSON should be:
      """
        {
          "name" : "ValidationDateError",
          "description" : "Start '209-03-31T20:30:00.000Z' does not match an ISO-8601 date format"
        }
      """

  @issue
  Scenario: Try to retrieve all created meetings setting the start field with an inexistent date
    Given I make a 'GET' request to '/meetings'
    And I set this queries:
      | owner | RM@arabitpro.local       |
      | start | 2019-02-31T20:30:00.000Z |
      | end   | 2019-03-31T20:30:00.000Z |
    When I execute the request
    Then I expect a '400' status code
    And the JSON should be:
      """
        {
          "name" : "ValidationDateError",
          "description" : "Start '2019-01-31T20:30:00.000Z' does not match an ISO-8601 date format"
        }
      """

  @issue
  Scenario: Try to retrieve all created meetings setting the end
  field with an invalid date
    Given I make a 'GET' request to '/meetings'
    And I set this queries:
      | owner | RM@arabitpro.local       |
      | start | 2019-03-31T20:30:00.000Z |
      | end   | 209-03-31T20:30:00.000Z  |
    When I execute the request
    Then I expect a '400' status code
    And the JSON should be:
      """
        {
          "name" : "ValidationDateError",
          "description" : "End '209-01-31T20:30:00.000Z' does not match an ISO-8601 date format"
        }
      """

  @issue
  Scenario: Try to retrieve all created meetings setting the end field with an inexistent date
    Given I make a 'GET' request to '/meetings'
    And I set this queries:
      | owner | RM@arabitpro.local       |
      | start | 2019-03-31T20:30:00.000Z |
      | end   | 2019-02-31T20:30:00.000Z |
    When I execute the request
    Then I expect a '400' status code
    And the JSON should be:
      """
        {
          "name" : "ValidationDateError",
          "description" : "End '2019-01-31T20:30:00.000Z' does not match an ISO-8601 date format"
        }
      """