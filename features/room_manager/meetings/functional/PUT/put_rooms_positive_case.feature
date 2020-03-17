# Author: Daniel Montecinos

@rm @meetings @functional @put @positive
Feature: PUT /meetings/{meetingId}

  Background:   Create a meeting and set 'rooms' with an array that
  contains at least one valid 'room' email (set the remaining parameters
  with correct values) and store its id
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
    And I store the '_id' as '{meetingId}'

  Scenario: Try to update the 'rooms' field of an exiting meeting with an
  array that contains four valid 'room' emails and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
          """
            {
              "organizer": "Administrator@arabitpro.local",
              "subject": "Subject Test",
              "body": "Body Test",
              "start": "2019-03-01T20:00:00.000Z",
              "end": "2019-03-01T20:30:00.000Z",
              "rooms": [
                "RMONE@arabitpro.local",
                "RMTWO@arabitpro.local",
                "RMTHREE@arabitpro.local",
                "RMFOUR@arabitpro.local"
              ],
              "attendees": [],
              "optionalAttendees": []
            }
          """
      And I execute the request
    Then I expect a '200' status code
      And the JSON at "rooms" should be:
        """
          [
            "RMONE@arabitpro.local",
            "RMTWO@arabitpro.local",
            "RMTHREE@arabitpro.local",
            "RMFOUR@arabitpro.local"
          ]
        """
