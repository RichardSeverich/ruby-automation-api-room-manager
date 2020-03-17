# Author: Daniel Montecinos

@rm @meetings @crud
Feature: GET /meetings

  Background: Create a meeting and set owner with a 'room' email
  and store its id
    Given I make a 'POST' request to '/meetings'
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
      And I store the response
      And I store the '_id' as '{meetingId}'

  Scenario: Retrieve a specific meeting
    When I make a 'GET' request to '/meetings/{meetingId}'
      And I change the "value" of "Credentials" to ""
      And I execute the request
      And after build a expected response with the fields:
        | _id               |
        | organizer         |
        | subject           |
        | owner             |
        | body              |
        | start             |
        | end               |
        | rooms             |
        | attendees         |
        | optionalAttendees |

    Then I expect a '200' status code
      And the built response should be equal to the obtained response
