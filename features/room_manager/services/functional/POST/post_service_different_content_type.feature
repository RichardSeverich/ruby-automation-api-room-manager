# Author: Pablo Ramirez
@rm @services @functional @negative
Feature: Post using content type

  Scenario Outline: Create a new service using different content-type
    Given I make a 'POST' request to '/services'
      And I change the "value" of "Content-Type" to "<content-type>"
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
    Then I expect a '400' status code

    Examples:
      | content-type    |
      | ""              |
      | application/xml |
      | application/txt |