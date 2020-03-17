# Author: Daniel Cabero

Feature: SMOKE, GET request to all exchanges meetings

  @delete_meetings @smoke @meetings
  Scenario: Retrieve all the created  exchanges meetings
    Given I make a 'GET' request to '/meetings'
    And I set this queries:
      | start | 2019-09-01T00:00:00.000Z |
      | end   | 2019-09-31T23:59:59.000Z |
    And I set this headers exchange:
      | Exchange-Credentials | 'Env.password'   |
      | Exchange-Calendar    | 'Env.user_mail'  |
    When I execute the request
    Then I expect a '200' status code
    And the JSON should be:
        """
          []
        """
