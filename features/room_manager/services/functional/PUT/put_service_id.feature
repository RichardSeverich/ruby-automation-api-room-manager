# Author: Pablo Ramirez
@rm @services @functional @negative
Feature: PUT an existing service with id field

  Scenario Outline: Update a service created using id field
    Given I make a 'PUT' request to '/services/<id>'
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
    Then I expect a '<status>' status code
      And the JSON should be:
              """
              {
                "name": "<response_name>",
                "description": "<response_description>"
              }
              """
    Examples:
      | id                           | status | response_name | response_description                                                                        |
      | c4f1b5c31b964cee796dca7c48e4 | 400    | BadRequest    | ServiceId argument passed in must be a String of 12 bytes or a string of 24 hex characters. |
      | b072c66329926592bb15b173     | 404    | NotFound      | ServiceId with value 'b072c66329926592bb15b173' does not exist.                             |
      | a508655276cba7051348         | 400    | BadRequest    | ServiceId argument passed in must be a String of 12 bytes or a string of 24 hex characters. |
