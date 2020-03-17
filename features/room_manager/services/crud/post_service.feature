# Author: Pablo Ramirez
@rm @services @crud
Feature: POST a new service

  @delete_services
  Scenario: : Create a new service using the correct and required parameters.
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
      And I store the response
      And after build a expected response with the fields:
          | _id            |
          | type           |
          | name           |
          | version        |
          | deleteLockTime |

    Then I expect a '200' status code
      And the JSON response at "name" should include "Exchange Server 2016"
      And the built response should be equal to the obtained response