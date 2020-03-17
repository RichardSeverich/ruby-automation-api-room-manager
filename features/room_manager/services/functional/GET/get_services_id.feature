# Author: Pablo Ramirez
@rm @services @functional @negative
Feature: GET request to room using an incorrect id query

  Scenario: Retrieve a room using an incorrect id query
    Given I make a 'GET' request to '/services'
      And I set this queries:
        | _id | incorrect |
    When I execute the request
    Then I expect a '400' status code
      And the JSON should be:
        """
        {
          "name": "ValidationError",
          "description": "The '._id' contains an invalid format."
        }
        """