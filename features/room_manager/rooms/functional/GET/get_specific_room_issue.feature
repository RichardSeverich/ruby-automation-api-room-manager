# Author: Pablo Ramirez
@rm @rooms @functional @negative @issue
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
      | id | status | response_name | response_description |
      |    | 404    | NotFound      | Room does not exist. |
