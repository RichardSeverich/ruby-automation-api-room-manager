# Author: Pablo Ramirez
@rm @rooms @functional @negative
Feature: Get all rooms using additional property names

  Scenario Outline: Retrieve all rooms using "new property" as property names
    Given I make a 'GET' request to '/rooms'
      And I set this queries:
        | $select | <property>               |
        | from    | 2017-01-01T00:00:01.000Z |
        | to      | 2017-01-01T00:00:59.000Z |
        | status  | <status>                 |
    When I execute the request
    Then I expect a '400' status code
      And the JSON should be:
            """
            {
              "name":"<response_name>",
              "description":"<response_description>"
            }
            """
    Examples:
      | property     | status | response_name     | response_description                                      |
      | new property | free   | InvalidFieldFound | Attribute field with value 'new property' does not exist. |
      | new property | busy   | InvalidFieldFound | Attribute field with value 'new property' does not exist. |