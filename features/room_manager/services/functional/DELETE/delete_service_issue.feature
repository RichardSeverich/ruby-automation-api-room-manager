# Author: Pablo Ramirez
@rm @services @functional @negative @issue
Feature: DELETE an existing service with id field

  Background: Create a service
    Given I make a 'POST' request to '/services'
      And I set this body:
        """
        {
          "hostname": "Env.hostname",
          "username": "Env.user",
          "password": "Env.password",
          "deleteLockTime": 11
        }
        """
      And I replace the values of the body request
    When I execute the request
    Then I store the '_id' as '{serviceId}'

  @delete_services
  Scenario Outline: Delete a service created using id field
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
      | id          | status | response_name | response_description |
      |             | 404    | NotFound      |                      |
      | {serviceId} | 204    | No Content    |                      |
