# Author: Daniel Montecinos

@rm @meetings @functional @post
Feature: POST /meetings

  @positive
  Scenario: Try to create a meeting setting an empty array as a value for the
  'optionalAttendees' parameter

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
  Scenario: Try to create a meeting, setting an array of 4 valid 'user' emails
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
            "optionalAttendees": [
              "agony@arabitpro.local",
              "dcabero@arabitpro.local",
              "jpaitken@arabitpro.local",
              "pablopzsj@arabitpro.local"
            ]
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
  Scenario: Try to create a meeting, setting an array of 4 'user'emails where at
  least one of them is a non valid email, as value for 'optionalAttendees' parameter in the request body
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
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": [
              "agony@arabitpro.local",
              "invalid_user_email@arabitpro.local",
              "jpaitken@arabitpro.local",
              "pablopzsj@arabitpro.local"
            ]
          }
        """
      And I execute the request
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
  Scenario: Try to create a meeting, setting an array of 4 'user' emails
  where at least the half of them are non valid emails, as value for
  'optionalAttendees' parameter in the request body
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
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": [
              "agony@arabitpro.local",
              "invalid_user_email_one@arabitpro.local",
              "invalid_user_email_two@arabitpro.local",
              "pablopzsj@arabitpro.local"
            ]
          }
        """
      And I execute the request
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
  Scenario: Try to create a meeting, setting an array of 4 'user' emails
  where all of them are the same, as value for 'optionalAttendees'
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
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": [
              "agony@arabitpro.local",
              "agony@arabitpro.local",
              "agony@arabitpro.local",
              "agony@arabitpro.local"
            ]
          }
        """
      And I execute the request

    Then I expect a '200' status code

  @positive
  Scenario: Try to create a meeting, setting an array of 4 'user' emails
  where none of them are valid emails, as value for 'optionalAttendees'
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
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": [
              "invalid_user_email_one@arabitpro.local",
              "invalid_user_email_two@arabitpro.local",
              "invalid_user_email_three@arabitpro.local",
              "invalid_user_email_four@arabitpro.local"
            ]
          }
        """
      And I execute the request
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
  Scenario: Try to create a meeting, setting an array of 4 numbers,
  as value for 'optionalAttendees' parameter in the request body
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
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": [
              1,
              2,
              3,
              4
            ]
          }
        """
      And I execute the request

    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name" : "ValidationError",
            "description" : "data.optionalAttendees[0] should be string"
          }
        """

  @negative
  Scenario: Try to create a meeting, setting an array of one valid
  'room' email, as value for 'optionalAttendees' parameter in the request
  body
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
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": [
              "RMONE@arabitpro.local"
            ]
          }
        """
      And I execute the request

    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name" : "InvalidInputError",
            "description" : "Cannot add this rooms : RMONE@arabitpro.local in optionalAttendees parameter"
          }
        """

  @negative
  Scenario Outline: Try to create a meeting, setting no arrays, as value for
  'optionalAttendees' parameter in the request body
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
              "RM@arabitpro.local"
            ],
            "attendees": [],
            "optionalAttendees": <optionalAttendees>
          }
        """
      And I execute the request

    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name" : "ValidationError",
            "description" : "data.optionalAttendees should be array"
          }
        """
    Examples:
      | optionalAttendees      |
      | ""                     |
      | "agonyarabitpro.local" |
      | "RM@arabitpro.local"   |
      | "0123456789"           |