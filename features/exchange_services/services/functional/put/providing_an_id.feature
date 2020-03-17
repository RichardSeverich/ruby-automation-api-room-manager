#Author: Juan Aitken
@functional
Feature: Functional test using PUT request on 'services' service

  Background: Create a service
    Given I make a 'POST' request to '/services'
    When  I load exchange server credentials
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


  @delete_services
  Scenario: PUT request providing a registered 'serviceId' and using the same credential

    Given I make a 'PUT' request to '/services/{serviceId}'
    When I load exchange server credentials
      And I set this body:
      """
       {
          "username": "Juan Aitken",
          "password": "P@ssw0rd"
        }
      """
    When I execute the request
    Then I expect a '200' status code












