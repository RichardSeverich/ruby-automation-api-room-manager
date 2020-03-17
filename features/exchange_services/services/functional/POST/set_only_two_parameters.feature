#Author: Juan Aitken
@functional @negative
Feature: POST request to 'services' service setting only two parameters on the body.


  @delete_services
  Scenario: POST request setting only 'hostname' and 'password'

    Given I make a 'POST' request to '/services'
      And I set this body:
          """
           {
             "hostname": "server2012dc.arabitpro.local",
             "password": "P@ssw0rd"
           }
          """
    When I execute the request
    Then I expect a '400' status code

  @delete_services
  Scenario: POST request setting only setting 'hostname' and 'username'

    Given I make a 'POST' request to '/services'
      And I set this body:
          """
           {
             "hostname": "server2012dc.arabitpro.local",
             "username": "Administrator"
           }
          """
    When I execute the request
    Then I expect a '400' status code

  @delete_services
  Scenario: POST request setting only 'username' and 'password'

    Given I make a 'POST' request to '/services'
      And I set this body:
          """
           {
             "username": "Administrator",
             "password": "P@ssw0rd"
           }
          """
    When I execute the request
    Then I expect a '400' status code














