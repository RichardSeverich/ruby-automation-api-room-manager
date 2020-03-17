#Author: Juan Aitken
@functional
Feature: POst request to 'services' service setting an IP
  @delete_services
  Scenario: POST request setting an ip instead a hostname in the 'hostname' parameter

   Given I make a 'POST' request to '/services'
     And I set this body:
            """
             {
               "hostname": "10.28.124.148",
               "username": "Administrator",
               "password": "P@ssw0rd"
             }
            """
   When I execute the request
   Then I expect a '200' status code