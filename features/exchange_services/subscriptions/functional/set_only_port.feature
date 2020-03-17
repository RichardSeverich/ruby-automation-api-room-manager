#Author: Juan Aitken
@functional @negative
Feature: POST request to 'subscription' service setting only 'port'

  Scenario:  POST request only setting a 'port' on the body

    Given I make a 'POST' request to '/subscriptions'
    When I load exchange server credentials
      And  I set this body:
       """
         {
           "port":7070
         }
       """
      And I execute the request
    Then I expect a '400' status code
      And a response body as:
       """
       {
            "name": "SchemaValidationError",
            "description": "data should have required property 'host'"
       }
       """