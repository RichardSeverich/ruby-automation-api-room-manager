#Author: Juan Aitken
@functional @negative
Feature: Functional test to Subscriptions using a 'port' where the application is not running and an invalid 'notificationUrl'

  @delete_subscriptions
  Scenario Outline:  POST request  setting  an invalid 'notificationUrl'

    Given I make a 'POST' request to '/subscriptions'
    When  I load exchange server credentials
      And  I set this body:
         """
          {
           "host": "localhost",
           "port": <port>,
           "notificationUrl": "<url>"
          }
         """
      And I execute the request
    Then I expect a '400' status code

    Examples:
      | port | url                   |
      | 7070 | not/validUrl/jalasoft |
      | 8080 | /api/v1/notifications |









