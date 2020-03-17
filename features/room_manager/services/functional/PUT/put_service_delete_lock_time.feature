# Author: Pablo Ramirez
@rm @services @functional @negative
Feature: PUT an existing service with deleteLockTime field

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
      And I store the '_id' as '{serviceId}'

  @delete_services
  Scenario Outline: Update a service created using deleteLockTime field
    Given I make a 'PUT' request to '/services/{serviceId}'
      And I set this body:
          """
          {
            "username": "Env.user",
            "password": "Env.password",
            "deleteLockTime": <delete_lock_time>
          }
          """
      And I replace the values of the body request
    When I execute the request
    Then I expect a '400' status code
      And the JSON should be:
              """
              {
                "name": "<response_name>",
                "description": "<response_description>"
              }
              """
    Examples:
      | delete_lock_time | response_name   | response_description                  |
      | 10.5             | ValidationError | data.deleteLockTime should be integer |
      | 500              | ValidationError | data.deleteLockTime should be <= 480  |
      | -500             | ValidationError | data.deleteLockTime should be >= 0    |
      | ""               | ValidationError | data.deleteLockTime should be integer |

