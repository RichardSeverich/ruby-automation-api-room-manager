#Author: Juan Aitken
@functional @negative
Feature: Functional test using PUT request on 'services' service

  Background: Create a service
    Given I make a 'POST' request to '/services'
    When I load exchange server credentials
    And I set this body:
         """
          {
            "hostname": "server2012dc.arabitpro.local",
            "username": "Administrator",
            "password": "P@ssw0rd"
          }
         """
    When I execute the request
    And I store the '_id' as '{serviceId}'

  @delete_services @negative
  Scenario Outline: Multiple negative PUT request

    Given I make a 'PUT' request to '/services/{serviceId}'
    When  I load exchange server credentials
    And  I set this body:
          """
          {
            "username": <user>,
            "password": <password>
          }
         """
    Then I execute the request
    And I expect a '<status_code>' status code

    Examples:

      | user               | password   | status_code |
      | "Reinaldo Aguilar" | "P@ssw0rd" | 401         |
      | "Juan Aitken "     | "CBA321}"  | 401         |
      | ""                 | "CBA321}"  | 400         |
      | "Juan Aitken "     | ""         | 400         |
      | ""                 | "P@"       | 400         |
      | 123456             | "P@ssw0rd" | 400         |
      | 123456             | "P@ssw0rd" | 400         |
      | "Juan Aitken"      | 123456     | 400         |



