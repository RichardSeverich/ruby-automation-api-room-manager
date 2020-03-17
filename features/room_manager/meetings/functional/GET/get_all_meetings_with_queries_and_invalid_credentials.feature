# Author: Daniel Montecinos

@rm @meetings @functional @get @negative
Feature: GET /meetings

  Scenario Outline: Try to retrieve all created meetings setting "Credentials"
  with different values
    Given I make a 'GET' request to '/meetings'
      And I change the "value" of "Credentials" to "<credentials>"
      And I set this queries:
        | owner | administrator@arabitpro.local |
        | start | 2019-03-01T20:00:00.000Z      |
        | end   | 2019-03-31T20:30:00.000Z      |
    When I execute the request
    Then I expect a '401' status code
      And the JSON should be:
        """
          {
            "name" : "UnauthorizedExchangeError",
            "description" : "The provided credentials are incorrect."
          }
        """
    Examples:
      | credentials      |
      | ""               |
      | invalid_password |
      | 0123456789       |
      | !@#$%^&*()       |
