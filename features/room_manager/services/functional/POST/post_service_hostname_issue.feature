# Author: Pablo Ramirez
@rm @services @functional @negative @issue
Feature: POST a service with a hostname

  Scenario Outline: Create a service with a hostname
    Given I make a 'POST' request to '/services'
      And I set this body:
          """
          {
            "hostname": <hostname>,
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
            "name":"<response_name>",
            "description":"<response_description>"
          }
          """
    Examples:
      | hostname                                                                                                                                                                                                                                                                                                                           | status | response_name           | response_description                                                  |
      | "10.28.124.148"                                                                                                                                                                                                                                                                                                                    | 409    | Conflict value          | Conflict with a domain with same name, the domain needs to be unique. |
      | "Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_" | 400    | InvalidCredentialsError | The credentials entered are not correct"                              |
