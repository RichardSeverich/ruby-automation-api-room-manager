#Author: Juan Aitken
@functional @negative
Feature: FUNCTIONAL negative scenarios for 'subscriptions' service

  Scenario Outline:  POST request setting a integer as 'host'

    Given I make a 'POST' request to '/subscriptions'
    When I load exchange server credentials
    And  I set this body:
          """
            {
             "host": <host>,
             "port": <port>,
             "notificationUrl": <url>
            }
          """
    And I execute the request
    Then I expect a '400' status code
    And a response body as:
        """
          {
          "name": "<name>",
          "description": "<description>"
          }
        """

    Examples:
      | host        | port      | url                      | name                  | description                           |
      | 100         | 7070      | "/api/v1/notifications " | SchemaValidationError | data.host should be string            |
      | "localhost" | ""        | " /api/v1/notifications" | SchemaValidationError | data.port should be integer           |
      | "localhost" | ""        | "/api/v1/notifications"  | SchemaValidationError | data.port should be integer           |
      | "localhost" | ""        | ""                       | SchemaValidationError | data.port should be integer           |
      | "localhost" | 7070      | 123                      | SchemaValidationError | data.notificationUrl should be string |
      | "localhost" | 123456789 | " /api/v1/notifications" | BadRequest            | The port is invalid.                  |
      | "localhost" | 7070      | ""                       | SchemaValidationError | The 'urlNotification' is invalid      |
      | ""          | 7070      | ""                       | SchemaValidationError | The '.host' is invalid                |
      | ""          | 7070      | "/api/v1/notifications"  | SchemaValidationError | The '.host' is invalid                |
      | ""          | ""        | ""                       | SchemaValidationError | The '.host' is invalid                |
      | ""          | ""        | "/api/v1/notifications"  | SchemaValidationError | The '.host' is invalid                |
      | ""          | ""        | ""                       | SchemaValidationError | The '.host' is invalid                |


