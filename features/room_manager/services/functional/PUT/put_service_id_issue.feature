# Author: Pablo Ramirez
@rm @services @functional @negative @issue
Feature: PUT an existing service with a empty id

  Scenario: Update a service created using a incorrect id
    Given I make a 'PUT' request to '/services/'
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
    Then I expect a '404' status code
      And the JSON should be:
              """
              {
                "name": "NotFound",
                "description": "Service does not exist."
              }
              """

