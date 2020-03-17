#Author: Juan Aitken
@functional @negative
Feature: POST request to 'services' service setting a empty json as body
Scenario: POST request with an empty json

   Given I make a 'POST' request to '/services'
     And I set this body:
          """
           {

           }
           """
   When I execute the request
   Then I expect a '400' status code
