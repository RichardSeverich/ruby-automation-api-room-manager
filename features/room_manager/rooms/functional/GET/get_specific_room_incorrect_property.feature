# Author: Pablo Ramirez
@rm @rooms @functional @negative
Feature: Get a specific room with incorrect property names

  Scenario: Retrieve a specific room using "new property" as property names
    Given I have obtained roomsId for 'room_four' from 'name' of the table 'rooms'
      And I make a 'GET' request to '/rooms'
      And I set this queries:
        | $select | new property |
    When I execute the request
    Then I expect a '400' status code
      And the JSON should be:
              """
              {
                "name":"InvalidFieldFound",
                "description":"Attribute field with value 'new property' does not exist."
              }
              """