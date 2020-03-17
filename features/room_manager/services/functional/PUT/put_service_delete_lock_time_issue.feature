# Author: Pablo Ramirez
@rm @services @functional @negative @issue
Feature: PUT an existing service an empty deleteLockTime
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
  Scenario: Update a service created using an empty deleteLockTime
    Given I make a 'PUT' request to '/services/{serviceId}'
      And I set this body:
            """
            {
              "username": "Env.user",
              "password": "Env.password",
              "deleteLockTime":
            }
            """
      And I replace the values of the body request
    When I execute the request
    Then I expect a '400' status code
      And the JSON should be:
              """
              {
                "name": "ValidationError",
                "description": "data.deleteLockTime should NOT be shorter than 1 characters"
              }
              """
