#Author: Juan Aitken
@functional @negative
Feature: POST request to 'services' service setting only one parameter on the body

Scenario: POST request only setting a valid 'hostname'

  Given I make a 'POST' request to '/services'
    And I set this body:
          """
           {
             "hostname": "server2012dc.arabitpro.local"

           }
          """
  When I execute the request
  Then I expect a '400' status code


Scenario: POST request only setting a valid 'username'

  Given I make a 'POST' request to '/services'
    And I set this body:
            """
             {
               "username": "Administrator"

             }
            """
  When I execute the request
  Then I expect a '400' status code


Scenario: POST request only setting a valid 'password'

  Given I make a 'POST' request to '/services'
    And I set this body:
           """
             {
               "password": "P@assw0rd"

             }
            """
  When I execute the request
  Then I expect a '400' status code