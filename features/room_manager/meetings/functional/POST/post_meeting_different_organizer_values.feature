# Author: Daniel Montecinos

@rm @meetings @functional @post
Feature: POST /meetings

  @negative @issue
  Scenario: Try to create a meeting setting an email other than
  "Administrator@arabitpro.local"value for the 'organizer' field,
  all the remaining values will set with correct values
    When I make a 'POST' request to '/meetings'
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

    Then I expect a '400' status code

  @negative
  Scenario: Try to create a meeting setting an invalid email as
  a value for the 'organizer' field, all the remaining values
  will set with correct values
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "!@#$%^&1234567890",
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
      And the JSON should be:
        """
        {
          "name" : "ValidationError",
          "description" : "data.organizer should match format \"email\""
        }
        """

  @negative
  Scenario: Try to create a meeting setting an empty string as
  a value for the 'organizer' field, all the remaining values
  will set with correct values
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "",
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
      And the JSON should be:
        """
        {
          "name" : "ValidationError",
          "description" : "data.organizer should NOT be shorter than 5 characters"
        }
        """
