# Author: Daniel Montecinos

@rm @meetings @functional @post @negative
Feature: POST /meetings

  Scenario Outline: Try to create a meeting using different
  content-types than the set by default (application/json)

    When I make a 'POST' request to '/meetings'
      And I change the "value" of "Content-Type" to "<content-type>"
      And I set this body:
        """
          {
            "organizer": "RM@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T20:00:00.000Z",
            "end": "2019-03-01T20:30:00.000Z",
            "rooms": [
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": []
          }
        """
      And I execute the request

    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name": "ValidationError",
            "description":"data should have required property 'organizer'"
          }
        """

    Examples:
      | content-type    |
      | ""              |
      | application/xml |
      | application/txt |