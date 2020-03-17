#Author: Juan Aitken
@functional @negative
Feature: POST request to 'subscriptions' service only setting 'hostname'

  Scenario:  POST request only setting a 'host' on the body

    Given I make a 'POST' request to '/subscriptions'
    When  I load exchange server credentials
      And  I set this body:
       """
         {
           "host": "localhost"
         }
       """
      And I execute the request
    Then I expect a '400' status code
      And a response body as:
       """
        {
        "name": "SchemaValidationError",
        "description": "data should have required property 'port'"
        }
       """