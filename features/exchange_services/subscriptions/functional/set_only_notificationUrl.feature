#Author: Juan Aitken
@functional @negative
Feature: POST request to 'subscriptions' service setting only  'notificationUrl'

  Scenario:  POST request only setting 'notificatonUrl' on the body

    Given I make a 'POST' request to '/subscriptions'
    When I load exchange server credentials
      And  I set this body:
       """
         {
           "notificationUrl": "/api/v1/notifications"
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

