# Author: Daniel Montecinos

@rm @meetings @functional @post @negative
Feature: POST /meetings

  Scenario Outline: Try to create a meeting only setting: organizer with
  a valid 'room' email, subject  and body with a  string greater than 0
  and less than or equal to 255, start and end with correct dates
  (start/date/hour < end/date/hour), rooms with an array that contains at
  least one valid 'room' email and attendees with different values
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T20:00:00.000Z",
            "end": "2019-03-01T20:30:00.000Z",
            "rooms": [],
            "attendees" : <attendees>
          }
        """
      And I execute the request

    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name" : "ValidationError",
            "description" : "data should have required property 'optionalAttendees'"
          }
        """
    Examples:
      | attendees                              |
      | []                                     |
      | ["RM@arabitpro.local"]                 |
      | ["invalid_room_email@arabitpro.local"] |
