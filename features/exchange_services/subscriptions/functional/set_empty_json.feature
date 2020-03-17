#Author: Juan Aitken
@functional @negative
Feature: POST request to 'subscriptions' service setting an empty json body

  Scenario:  POST request  setting  empty json as body

    Given I make a 'POST' request to '/subscriptions'
    When I load exchange server credentials
      And  I set this body:
       """
         {
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