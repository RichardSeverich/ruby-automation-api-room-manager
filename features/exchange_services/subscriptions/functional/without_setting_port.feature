#Author: Juan Aitken
@functional @negative
Feature: POST request to 'subscriptions' service without setting 'port'

  Scenario:  POST request setting a empty string as 'port'

    Given I make a 'POST' request to '/subscriptions'
    When I load exchange server credentials
      And  I set this body:
         """
          {
           "host": "localhost",
           "notificationUrl": "/api/v1/notifications"
          }
         """
      And I execute the request
    Then I expect a '400' status code
      And  a response body as:
         """
         {
          "name": "SchemaValidationError",
          "description": "data should have required property 'port'"
         }
         """