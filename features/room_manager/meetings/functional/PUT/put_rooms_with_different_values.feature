# Author: Daniel Montecinos

@rm @meetings @functional @put @negative
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
  array that contains four invalid 'room' emails and using a valid id
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
              "invalid_room_one@arabitpro.local",
              "invalid_room_two@arabitpro.local",
              "invalid_room_three@arabitpro.local",
              "invalid_room_four@arabitpro.local"
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
          "name" : "InvalidInputError",
          "description" : "Cannot add this attendees : invalid_room_one@arabitpro.local,invalid_room_two@arabitpro.local,invalid_room_three@arabitpro.local,invalid_room_four@arabitpro.local in rooms parameter"
        }
      """

  Scenario: Try to update the 'rooms' field of an exiting meeting with an
  array that contains four  'room' emails where all of them are the same and using a valid id
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
              "RMONE@arabitpro.local",
              "RMONE@arabitpro.local",
              "RMONE@arabitpro.local"
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
          "name" : "MeetingNotUpdated",
          "description" : "The meeting could not be Updated"
        }
      """

  Scenario: Try to update the 'rooms' field of an exiting meeting with an
  array that contains four  numeric values and using a valid id
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
              1,
              2,
              3,
              4
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
          "name" : "ValidationError",
          "description" : "data.rooms[0] should be string"
        }
      """

  Scenario: Scenario: Try to update the 'rooms' field of an exiting meeting
  with an array of four empty strings and using a valid id
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
              "",
              "",
              "",
              ""
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
          "name" : "ValidationError",
          "description" : "data.rooms[0] should NOT be shorter than 5 characters"
        }
      """
