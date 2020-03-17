# Author: Daniel Montecinos

@rm @meetings @functional @post @negative
Feature: POST /meetings

  Scenario: Try to create a meeting, setting an empty string as the value
  for both date fields
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject" : "Subject Test",
            "body": "Body Test",
            "start": "",
            "end": "",
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
            "description" : "data.start should match format \"date-time\""
          }
        """

  Scenario Outline: Try to create a meeting, setting invalid start/dates
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject" : "Subject Test",
            "body": "Body Test",
            "start": "<start-date>",
            "end": "<end-date>",
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
            "description" : "data.start should match format \"date-time\""
          }
        """
    Examples:
      | start-date                   | end-date                     |
      | start-date                   | end-date                     |
      | 2019-03-01                   | 2019-03-31                   |
      | 2019-03-01T000:000:000.0000Z | 2019-03-31T020:30:00.000Z    |
      | 209-03-01T000:000:000.0000Z  | 2019-03-31T020:30:00.000Z    |
      | -03-01T00:00:00.000Z         | 2019-03-31T020:30:00.000Z    |

  Scenario Outline: Try to create a meeting, setting invalid end/dates
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject" : "Subject Test",
            "body": "Body Test",
            "start": "<start-date>",
            "end": "<end-date>",
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
            "description" : "data.end should match format \"date-time\""
          }
        """
    Examples:
      | start-date               | end-date                 |
      | 2019-03-01T20:00:00.000Z | -03-31T23:59:59.000Z     |
      | 2019-03-01T20:00:00.000Z | 2019-03-31TZ             |
      | 2019-03-01T20:00:00.000Z | 2019-03-31T@#:00:--.$$$Z |

  Scenario Outline: Try to create a meeting, setting a start date greater
  than the end date
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject" : "Subject Test",
            "body": "Body Test",
            "start": "<start-date>",
            "end": "<end-date>",
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
            "name" : "SchemaValidationError",
            "description" : "Start shouldn't be greater than End."
          }
        """
    Examples:
      | start-date               | end-date                 |
      | 2019-03-31T00:00:00.000Z | 2019-03-01T23:59:59.000Z |
      | 2020-03-29T00:00:00.000Z | 2016-02-28T23:59:59.000Z |
      | 2019-03-31T00:00:00.000Z | 2019-03-01T00:00:00.000Z |

  @issue
  Scenario Outline: Try to create a meeting, setting a start with a date equal than end date
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject" : "Subject Test",
            "body": "Body Test",
            "start": "<start-date>",
            "end": "<end-date>",
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
  #      """
  #        {
  #          "name" : "SchemaValidationError",
  #          "description" : "Start shouldn't be greater than End."
  #        }
  #      """
    Examples:
      | start-date               | end-date                 |
      #IT IS ALLOWED THAT THE START AND END HOUR BE THE SAME
      | 2019-03-01T00:00:00.000Z | 2019-03-01T00:00:00.000Z |
      #IT IS ALLOWED THAT THE START AND END HOUR BE THE SAME
      | 2019-03-01T23:59:59.000Z | 2019-03-01T23:59:59.000Z |
      #IT IS ALLOWED THAT THE START AND END HOUR BE THE SAME
      | 2019-03-31T00:00:00.000Z | 2019-03-31T00:00:00.000Z |
      # APPARENTLY I CAN CREATE THIS MEETING BUT IT IS NOT TRUE
      | 2019-03-31T23:59:59.000Z | 2019-03-31T23:59:59.000Z |

  Scenario Outline: Try to create a meeting, setting a start and end with inexistent dates
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer": "administrator@arabitpro.local",
            "subject" : "Subject Test",
            "body": "Body Test",
            "start": "<start-date>",
            "end": "<end-date>",
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
            "name" : "ExchangeError",
            "description" : "The specified date isn't valid."
          }
        """
    Examples:
      | start-date               | end-date                 |
      #ISOLATE THIS IT IS ANOTHER TYPE OF ERROR, THE ERROR SAYS
      #THE DOESN'T EXIST, BUT IT DOESN'T SPECIFY WHICH DATE
      | 2019-02-31T23:59:59.000Z | 2019-03-31T23:59:59.000Z |
      | 2019-02-01T00:00:00.000Z | 2019-02-31T00:00:00.000Z |