# Author: Daniel Montecinos

@rm @meetings @functional @put @negative
Feature: PUT /meetings/{meetingId}

  Background: Create a meeting an store its id
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
      And I store the 'id' as '{meetingId}'

  Scenario: Try to update an existing meeting making use of an invalid id
    When I make a 'PUT' request to '/meetings/{invalidId}'
      And I set this body:
        """
          {
            "organizer": "agony@arabitpro.local",
            "subject": "Subject Test Updated",
            "body": "Body Test Updated",
            "start": "2019-03-01T21:00:00.000Z",
            "end": "2019-03-01T21:30:00.000Z",
            "rooms": [
              "RMONE@arabitpro.local"
            ],
            "attendees": [
              "agony@arabitpro.local"
            ],
            "optionalAttendees": [
              "agony@arabitpro.local"
            ]
          }
        """
      And I execute the request

    Then I expect a '404' status code
      And the JSON should be:
        """
          {
            "name" : "MeetingNotFoundError",
            "description" : "The meeting doesn't exist in the database."
          }
        """