#Author: Juan Aitken
@functional @negative
Feature: PUT request to 'services' services without provide an ID

Scenario: PUT request with out ID

Given I make a 'PUT' request to '/services/'
When I load exchange server credentials
  And I set this body:
      """
       {
        "username": "Juan Aitken",
        "password": "P@ssw0rd"

        }
       """
When I execute the request
Then I expect a '400' status code