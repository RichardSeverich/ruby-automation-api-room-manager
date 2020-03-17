# Author: Pablo Ramirez
@rm @services @crud
Feature: GET request to all rooms

  @delete_services
  Scenario: Retrieve all the created services
    Given I make a 'GET' request to '/services'
    When I execute the request
    Then I expect a '200' status code
      And the JSON should be:
        """
        []
        """