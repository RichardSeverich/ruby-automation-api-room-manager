# Author: Pablo Ramirez
@rm @services @crud
Feature: DELETE an existing service

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
  Scenario: Delete a service created using the retrieved id

    Given I make a 'DELETE' request to '/services/{serviceId}'
    When I execute the request
    Then I expect a '200' status code
      And the response should not include the field "_id"

