# Author: Pablo Ramirez
@rm @services @functional @negative @issue
Feature: POST a new service with deleteLockTime field

  Scenario Outline: Create a new service using deleteLockTime field
    Given I make a 'POST' request to '/services'
      And I set this body:
            """
            {
              "hostname": "Env.hostname",
              "username": "Env.user",
              "password": "Env.password",
              "deleteLockTime": <delete_Lock_Time>
            }
            """
      And I replace the values of the body request
    When I execute the request
    Then I expect a '400' status code
      And the JSON should be:
                """
                {
                  "name":"<response_name>",
                  "description":"<response_description>"
                }
                """
    Examples:
      | delete_Lock_Time | response_name           | response_description                                        |
      |                  | ValidationError         | data.deleteLockTime should NOT be shorter than 1 characters |
      | incorrect        | InvalidCredentialsError | The credentials entered are not correct                     |
