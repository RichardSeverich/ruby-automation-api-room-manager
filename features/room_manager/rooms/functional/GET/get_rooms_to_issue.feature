# Author: Pablo Ramirez
@rm @rooms @functional @negative @issue
Feature: Get all rooms using field "to"

  Scenario Outline: Retrieve all rooms using field "to"
  using status free
    Given I make a 'GET' request to '/rooms'
      And I set this queries:
        | $select | name                     |
        | from    | 2017-01-01T00:00:00.000Z |
        | to      | <to>                     |
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
      | to             | status | response_name | response_description                             |
      | incorrect data | free   | NotFound      | From with value 'incorrect data' does not exist. |
      | incorrect data | busy   | NotFound      | From with value 'incorrect data' does not exist. |
      | 2017-02-31     | free   | BadRequest    |                                                  |
      | 2017-02-31     | busy   | BadRequest    |                                                  |

