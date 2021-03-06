# Author: Daniel Montecinos

@rm @meetings @functional @put @issue
Feature: PUT /meetings/{meetingId}

  Background: Create a meeting and set 'organizer' parameter with a valid
  'user' email (set the remaining parameters with correct values) and
  store its id
    Given I make a 'POST' request to '/meetings'
      And I set this body:
        """
        {
          "organizer": "administrator@arabitpro.local",
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
      And I store the '_id' as '{meetingId}'

  Scenario: Try to update the 'organizer' field of an exiting meeting with
  another 'user' email and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "agony@arabitpro.local",
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
    Then I expect a '200' status code
      And the JSON at "organizer" should be "agony@arabitpro.local"

  Scenario: Try to update the 'organizer' field of an exiting meeting with
  an invalid 'user' email and using a valid id

    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "invalid_user_name@arabitpro.local",
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
