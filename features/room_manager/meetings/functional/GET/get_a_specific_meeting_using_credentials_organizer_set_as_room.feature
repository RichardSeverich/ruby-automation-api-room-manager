# Author: Daniel Montecinos

@rm @meetings @functional @get @negative @issue
Feature: GET /meetings/{meetingId}

  Background: Create a meeting setting a valid 'room' as a value
  for 'organizer' field and store its id
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

  Scenario: Try to retrieve a specific meeting using a valid id
  and using credentials
    When I make a 'GET' request to '/meetings/{meetingId}'
      And I execute the request

      Then I expect a '400' status code
