# Author: Pablo Ramirez
@rm @services @smoke @positive
Feature: GET request to all rooms

  @delete_services
  Scenario: Retrieve all the created meetings
    Given I make a 'GET' request to '/services'
    When I execute the request
    Then I expect a '200' status code
      And the JSON should be:
        """
        []
        """