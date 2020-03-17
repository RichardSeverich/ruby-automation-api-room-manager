#Author: Juan Aitken
@functional @negative
Feature: Functional test using PUT request on 'services' with out setting completely body

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

  @delete_services
  Scenario: PUT request providing a registered 'serviceId' and only setting a valid 'username'

    Given I make a 'PUT' request to '/services/{serviceId}'
    When I load exchange server credentials
      And I set this body:
        """
         {
            "username": "Juan Aitken"
          }
        """
    When I execute the request
    Then I expect a '400' status code

  @delete_services
  Scenario: PUT request providing a registered 'serviceId' and only setting a  'password'

    Given I make a 'PUT' request to '/services/{serviceId}'
    When I load exchange server credentials
      And I set this body:
      """
       {
          "password": "P@ssw0rd"
        }
      """
    When I execute the request
    Then I expect a '400' status code

  @delete_services
  Scenario: PUT request providing a registered 'serviceId' and only setting a  'password'

    Given I make a 'PUT' request to '/services/{serviceId}'
    When I load exchange server credentials
      And I set this body:
        """
         {

         }
        """
    When I execute the request
    Then I expect a '400' status code