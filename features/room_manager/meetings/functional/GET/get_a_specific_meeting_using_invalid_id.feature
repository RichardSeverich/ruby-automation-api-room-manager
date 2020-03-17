# Author: Daniel Montecinos

@rm @meetings @functional @get @negative
Feature: GET /meetings/{meetingId}

  Background: Create a meeting and store its id
    Given I make a 'POST' request to '/meetings'
      And I set this body:
        """
        {
          "organizer": "Administrator@arabitpro.local",
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
      And I store the 'id' as '{invalidId}'

  Scenario: Retrieve a specific meeting using an invalid id
    When I make a 'GET' request to '/meetings/{invalidId}'
      And I execute the request
      And after build a expected response with the fields:
        | _id               |
        | organizer         |
        | subject           |
        | body              |
        | start             |
        | end               |
        | rooms             |
        | attendees         |
        | optionalAttendees |

    Then I expect a '404' status code
      And the JSON should be:
        """
          {
            "name" : "MeetingNotFoundError",
            "description" : "The meeting doesn't exist in the database."
          }
        """

