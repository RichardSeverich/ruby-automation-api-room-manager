# Author: Pablo Ramirez
@rm @services @functional @negative
Feature: POST a service with a hostname field

  Scenario Outline: Create a service with a hostname field
    Given I make a 'POST' request to '/services'
      And I set this body:
            """
            {
              "hostname": <hostname>,
              "username": "Administrator",
              "password": "P@ssw0rd",
              "deleteLockTime": 11
            }
            """
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
      | hostname                       | status | response_name             | response_description                                                                                              |
      | "server2012dc.ArabITPro.local" | 409    | Conflict value            | Conflict with a domain with same name, the domain needs to be unique.                                             |
      | ""                             | 400    | ValidationError           | data.hostname should NOT be shorter than 1 characters                                                             |
      | 2017                           | 400    | ValidationError           | data.hostname should be string                                                                                    |
      | "incorrect"                    | 409    | RequestNetBIOSDomainError | Can't connect to LDAP server, please ensure the NetBIOS domain is correct and your computer belongs to the domain |
