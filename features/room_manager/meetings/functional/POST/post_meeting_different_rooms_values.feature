# Author: Daniel Montecinos

@rm @meetings @functional @post
Feature: POST /meetings

  @positive
  Scenario: Try to create a meeting setting an empty array
  as a value for the 'rooms' parameter

    Given I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T20:00:00.000Z",
            "end": "2019-03-01T20:30:00.000Z",
            "rooms": [],
            "attendees": [],
            "optionalAttendees": []
          }
        """
    When I execute the request
      And I store the response
      And after build a expected response with the fields:
        | _id               |
        | organizer         |
        | subject           |
        | body              |
        | start             |
        | end               |
        | rooms             |
        | attendees         |
        | optionalAttendees |

    Then I expect a '200' status code
      And the built response should be equal to the obtained response

  @positive
  Scenario: Try to create a meeting, setting an array of 4 valid 'room' emails
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
              "RMONE@arabitpro.local",
              "RMTWO@arabitpro.local",
              "RMTHREE@arabitpro.local",
              "RMFOUR@arabitpro.local"
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
        | subject           |
        | body              |
        | start             |
        | end               |
        | rooms             |
        | attendees         |
        | optionalAttendees |

    Then I expect a '200' status code
      And the built response should be equal to the obtained response


  @negative
  Scenario: Try to create a meeting, setting an array of 4 'room'emails
  where at least one of them is a non valid email, as value for 'rooms'
  parameter in the request body
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T20:00:00.000Z",
            "end": "2019-03-01T20:30:00.000Z",
            "rooms": [
              "invalid_room@arabitpro.local",
              "RMTWO@arabitpro.local",
              "RMTHREE@arabitpro.local",
              "RMFOUR@arabitpro.local"
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
            "description" : "Cannot add this attendees : invalid_room@arabitpro.local in rooms parameter"
          }
        """

  @negative
  Scenario: Try to create a meeting, setting an array of 4 'room' emails where at
  least the half of them are non valid emails, as value for 'rooms' parameter in the
  request body
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T20:00:00.000Z",
            "end": "2019-03-01T20:30:00.000Z",
            "rooms": [
              "invalid_room_one@arabitpro.local",
              "RMTWO@arabitpro.local",
              "RMTHREE@arabitpro.local",
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
            "description" : "Cannot add this attendees : invalid_room_one@arabitpro.local,invalid_room_four@arabitpro.local in rooms parameter"
          }
        """

  @negative @issue
  Scenario: Try to create a meeting, setting an array of 4 'room' emails
  where all of them are the same, as value for 'rooms'
  parameter in the request body
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T20:00:00.000Z",
            "end": "2019-03-01T20:30:00.000Z",
            "rooms": [
              "RM@arabitpro.local",
              "RM@arabitpro.local",
              "RM@arabitpro.local",
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": []
          }
        """
      And I execute the request

    Then I expect a '400' status code

  @negative
  Scenario: Try to create a meeting, setting an array of 4 'room' emails
  where none of them are valid emails, as value for 'rooms' parameter in
  the request body
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T20:00:00.000Z",
            "end": "2019-03-01T20:30:00.000Z",
            "rooms": [
              "invalid_room@arabitpro.local",
              "invalid_room@arabitpro.local",
              "invalid_room@arabitpro.local",
              "invalid_room@arabitpro.local"
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
            "description" : "Cannot add this attendees : invalid_room@arabitpro.local,invalid_room@arabitpro.local,invalid_room@arabitpro.local,invalid_room@arabitpro.local in rooms parameter"
          }
        """

  @negative
  Scenario: Try to create a meeting, setting an array of 4 numbers, as value for
  'rooms' parameter in the request body
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
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

  @negative
  Scenario Outline:  Try to create a meeting, setting no arrays, as value for
  'rooms' parameter in the request body
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T20:00:00.000Z",
            "end": "2019-03-01T20:30:00.000Z",
            "rooms": <rooms>,
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
            "description" : "data.rooms should be array"
          }
        """
    Examples:
      | rooms                |
      | ""                   |
      | "RM@arabitpro.local" |
      | "0123456789"         |