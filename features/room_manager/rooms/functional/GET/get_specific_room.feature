# Author: Pablo Ramirez
@rm @rooms @functional @negative
Feature: Get a specific room using id

  Scenario Outline: Retrieve a specific room using id
    Given I make a 'GET' request to '/rooms/<id>'
    When I execute the request
    Then I expect a '<status>' status code
      And the JSON should be:
              """
              {
                "name":"<response_name>",
                "description":"<response_description>"
              }
              """
    Examples:
      | id                           | status | response_name | response_description                                                                     |
      | 2a9332bd958e23f4eb1d209f8d67 | 400    | BadRequest    | RoomId argument passed in must be a String of 12 bytes or a string of 24 hex characters. |
      | 551b7cbce25cd1d2             | 400    | BadRequest    | RoomId argument passed in must be a String of 12 bytes or a string of 24 hex characters. |
      | 339e107191c289649720d48e     | 404    | NotFound      | Room with value '339e107191c289649720d48e' does not exist.                               |
