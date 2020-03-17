# Author: Daniel Montecinos

@rm @meetings @smoke
Feature: Get /meetings

  @delete_meetings
  Scenario: Retrieve all the created meetings without use queries and
    credentials
    Given I make a 'GET' request to '/meetings'
      And I change the "value" of "Credentials" to ""
    When I execute the request
    Then I expect a '200' status code
      And the JSON should be:
      """
        []
      """
     