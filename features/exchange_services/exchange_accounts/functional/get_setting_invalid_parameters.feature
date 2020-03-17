#Author: Juan Aitken
@smoke @test
Feature: SMOKE, GET request to /meetings service

  Scenario Outline:
    Given  I make a 'GET' request to '/exchangeAccount'
    When  I set the headers:
      | Exchange-Credentials | <credentials> |
    And I set this queries:
      | hostname | <host> |
    Then I execute the request
    And I expect a '<status_code>' status code
    And a response body as:
                     """
                      {
                      "name": "<name>",
                      "description": "<description>"
                      }
                     """

    Examples:
      | credentials                      | host                         | status_code | name                    | description                             |
      | QWRtaW5pc3RyYXRvcjpQQHNzdzByQW== | server2012dc.ArabITPro.local | 401         | InvalidCredentialsError | The credentials entered are not correct |
      | QWRtaW5pc3RyYXRvcjpQQHNzdzByQW== | invalid.server.local         | 400         | InvalidHostError        | Invalid host 'invalid.server.local'     |
      | 123456789                        | server2012dc.ArabITPro.local | 400         | BadRequest              | Wrong decoded credentials format.       |
      | QWRtaW5pc3RyYXRvcjpQQHNzdzByZA== | ""                           | 400         | InvalidHostError        | Ldap service not found on host '\"\"'   |
      | ""                               | server2012dc.ArabITPro.local | 400         | BadRequest              | Wrong decoded credentials format.       |
      | ""                               | ""                           | 400         | BadRequest              | Wrong decoded credentials format.       |



