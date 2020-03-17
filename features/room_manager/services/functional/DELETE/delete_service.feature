# Author: Pablo Ramirez
@rm @services @functional @negative
Feature: DELETE an existing service

  @delete_services
  Scenario Outline: Delete a service created
    Given I make a 'DELETE' request to '/services/<id>'
    When I execute the request
    Then I expect a '<status>' status code
      And the JSON should be:
          """
          {
            "name": "<response_name>",
            "description": "<response_description>"
          }
          """
    Examples:
      | id                       | status | response_name | response_description                                            |
      | 87249b962b3c02d379df8c34 | 404    | NotFound      | ServiceId with value '87249b962b3c02d379df8c34' does not exist. |


