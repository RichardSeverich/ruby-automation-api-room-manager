# Author: Daniel Montecinos

@rm @meetings @crud @issue
Feature: PUT /meetings/{meetingId}

  Background: Create a meeting, set a 'room' email as a value
  for the 'organizer' field and store its id
    Given I make a 'POST' request to '/meetings'
      And I set this body:
          """
            {
              "organizer": "RM@arabitpro.local",
              "subject": "Subject Test",
              "body": "Body Test",
              "start": "2019-03-01T20:00:00.000Z",
              "end": "2019-03-01T20:30:00.000Z",
              "rooms": [],
              "attendees": [],
              "optionalAttendees": []
            }
          """
      And I execute the request
      And I store the '_id' as '{meetingId}'

  Scenario: Update an existing meeting, setting 'organizer' with another
  valid 'room' email

    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "RMONE@arabitpro.local",
            "subject": "Subject Updated",
            "body": "Body Updated",
            "start": "2019-03-01T21:00:00.000Z",
            "end": "2019-03-01T21:30:00.000Z",
            "rooms": [],
            "attendees": [],
            "optionalAttendees": []
          }
        """
      And I execute the request
      And I construct a expected response adding this fields:
        | _id   |
        | body  |
        | owner |

    Then I expect a '200' status code
      And the built expected response should be equal to the obtained response
