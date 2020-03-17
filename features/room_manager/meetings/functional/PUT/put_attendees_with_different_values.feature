# Author: Daniel Montecinos

@rm @meetings @functional @put
Feature: PUT /meetings/{meetingID}

  Background: Create a meeting and set 'attendees' with an array of zero
  or more valid 'user' emails (set the remaining parameters with correct
  values) and store its id
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

  @positive
  Scenario: Try to update the 'attendees' field of an exiting meeting with
  an array of four invalid 'user' emails and using a valid id
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
              "RM@arabitpro.local"
            ],
            "attendees": [
              "invalid_user_one@arabitpro.local",
              "invalid_user_two@arabitpro.local",
              "invalid_user_three@arabitpro.local",
              "invalid_user_four@arabitpro.local"
            ],
            "optionalAttendees": []
          }
        """
      And I execute the request
    Then I expect a '200' status code
      And the JSON at "attendees" should be:
        """
          [
            "invalid_user_one@arabitpro.local",
            "invalid_user_two@arabitpro.local",
            "invalid_user_three@arabitpro.local",
            "invalid_user_four@arabitpro.local"
          ]
        """

  @negative
  Scenario: Try to update the 'attendees' field of an exiting meeting with
  an array that contains four 'user' emails where all of them are the same
  and using a valid id
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
              "RM@arabitpro.local"
            ],
            "attendees": [
              "agony@arabitpro.local",
              "agony@arabitpro.local",
              "agony@arabitpro.local",
              "agony@arabitpro.local"
            ],
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

  @negative
  Scenario: Try to update the 'attendees' field of an exiting meeting
  with an array of four numeric values and using a valid id
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
              "RM@arabitpro.local"
            ],
            "attendees": [
              1,
              2,
              3,
              4
            ],
            "optionalAttendees": []
          }
        """
      And I execute the request
    Then I expect a '400' status code
      And the JSON should be:
      """
        {
          "name" : "ValidationError",
          "description" : "data.attendees[0] should be string"
        }
      """

  @negative
  Scenario: Scenario: Try to update the 'attendees' field of an exiting meeting
  with an array of four empty strings and using a valid id
    When I make a 'PUT' request to '/meetings/{validId}'
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
            "attendees": [
              "",
              "",
              "",
              ""
            ],
            "optionalAttendees": []
          }
        """
      And I execute the request
    Then I expect a '400' status code
      And the JSON should be:
      """
        {
          "name" : "ValidationError",
          "description" : "data.attendees[0] should NOT be shorter than 5 characters"
        }
      """

  @positive
  Scenario: Try to update the 'attendees' field of an exiting meeting with an
  array that contains four valid 'user' emails and using a valid id
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
                  "RM@arabitpro.local"
                ],
                "attendees": [
                  "agony@arabitpro.local",
                  "pablopzsj@arabitpro.local",
                  "jpaitken@arabitpro.local",
                  "dcabero@arabitpro.local"
                ],
                "optionalAttendees": []
              }
            """
      And I execute the request
    Then I expect a '200' status code
      And the JSON at "attendees" should be:
        """
          [
            "agony@arabitpro.local",
            "pablopzsj@arabitpro.local",
            "jpaitken@arabitpro.local",
            "dcabero@arabitpro.local"
          ]
        """
