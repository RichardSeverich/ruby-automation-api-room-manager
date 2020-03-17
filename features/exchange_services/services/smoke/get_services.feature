#Author: Juan Aitken
@smoke
  Feature: SMOKE, GET request to services
  @delete_services
  Scenario: Retrieve  the all the services
    Given I make a 'GET' request to '/services'
      And I load exchange server credentials
    When I execute the request
    Then I expect a '200' status code
      And a response body as:
        """
             []
        """