#Author: Juan Aitken
@functional @negative
Feature: POST request to 'services' service setting invalid parameters

  @delete_services
  Scenario Outline:

    Given I make a 'POST' request to '/services'
    When I load exchange server credentials
    And I set this body:
         """
         {
         "hostname": <hostname>,
         "username": <user>,
         "password": <password>
         }
         """
    When  I execute the request
    Then I expect a '<status_code>' status code
    And a response body as:
      """
        {
        "name": "<name>",
        "description": "<description>"
        }
      """
    Examples:

      | hostname                       | user            | password    | status_code | name                      | description                                                                                                       |
      | "fundacionjala.local"          | "Administrator" | "P@ssw0rd"  | 409         | RequestNetBIOSDomainError | Can't connect to LDAP server, please ensure the NetBIOS domain is correct and your computer belongs to the domain |
      | "server2012dc.arabitpro.local" | "invalid"       | "P@ssw0rd"  | 401         | InvalidCredentialsError   | The credentials entered are not correct                                                                           |
      | "server2012dc.arabitpro.local" | "Administrator" | "ABC12345}" | 401         | InvalidCredentialsError   | The credentials entered are not correct                                                                           |
      | "server2012dc.arabitpro.local" | ""              | "P@ssw0rd"  | 400         | SchemaValidationError     | The '.username' is invalid                                                                                        |
      | "server2012dc.arabitpro.local" | "Administrator" | ""          | 400         | SchemaValidationError     | The '.password' is invalid                                                                                        |
      | ""                             | "Administrator" | "P@ssw0rd"  | 400         | SchemaValidationError     | The '.hostname' is invalid                                                                                        |
      | "server2012dc.arabitpro.local" | 789145789       | "P@ssw0rd"  | 400         | SchemaValidationError     | data.username should be string                                                                                    |
      | "server2012dc.arabitpro.local" | "Administrator" | 123456      | 400         | SchemaValidationError     | data.password should be string                                                                                    |
      | 1028124134                     | "Administrator" | "P@ssw0rd"  | 400         | SchemaValidationError     | data.hostname should be string                                                                                    |
