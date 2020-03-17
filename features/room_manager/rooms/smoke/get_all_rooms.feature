# Author: Pablo Ramirez
@rm @rooms @smoke
Feature: GET request to all rooms

  @delete_rooms
  Scenario Outline: Get all rooms with status free
    Given I make a 'GET' request to '/rooms'
      And I set this queries:
        | from   | 2017-01-01T00:00:01.000Z |
        | to     | 2017-01-01T00:00:59.000Z |
        | status | <status>                 |
    When I execute the request
    Then I expect a '200' status code
      And the JSON should be:
        """
        []
        """
    Examples:
      | status |
      | free   |
      | busy   |

