# Author: Daniel Montecinos

@rm @meetings @crud
Feature: POST /meetings

  Scenario: Create a meeting setting the field 'organizer' with a valid 'room' email
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
    When I execute the request
      And I store the response
      And after build a expected response with the fields:
        | _id               |
        | organizer         |
        | owner             |
        | subject           |
        | body              |
        | start             |
        | end               |
        | rooms             |
        | attendees         |
        | optionalAttendees |

    Then I expect a '200' status code
      And the JSON response at "owner" should include "RM@arabitpro.local"
      And the built response should be equal to the obtained response
