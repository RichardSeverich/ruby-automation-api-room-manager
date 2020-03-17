# Author: Daniel Montecinos

@rm @meetings @functional @get @positive
Feature: GET /meetings
  @delete_meetings
  Scenario: Try to retrieve all created meetings between a specific period of
  time, for example from 20:00 PM to 20.30 PM
    Given I make a 'GET' request to '/meetings'
      And I set this queries:
        | owner | administrator@arabitpro.local |
        | start | 2019-03-01T20:00:00.000Z      |
        | end   | 2019-03-31T20:30:00.000Z      |
    When I execute the request
    Then I expect a '200' status code
      And the JSON should be:
        """
          []
        """
