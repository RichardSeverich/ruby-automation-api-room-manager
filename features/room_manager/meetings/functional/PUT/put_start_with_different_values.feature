# Author: Daniel Montecinos

@rm @meetings @functional @put
Feature: PUT /meetings/{meetingId}

  Background: Create a meeting and set 'start' field with correct dates,
  e.g. 2019-03-01T20:00:00.000Z (set the remaining parameters with correct
  values), store its id and take note the date the 'end' field has
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

  @negative
  Scenario: Try to update the 'start' field of an exiting meeting with a
  date less than the 'end' field has, but using '/' as date separator
  instead '-' and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "Administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019/03/01T19:00:00.000Z",
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
          "description" : "data.start should match format \"date-time\""
        }
      """

  @positive
  Scenario: Try to update the 'start' field of an exiting meeting with an
  hour less than the 'end' field has and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "Administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-02-01T19:00:00.000Z",
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
      And the JSON at "start" should be "2019-02-01T19:00:00.000Z"

  @negative
  Scenario: Try to update the 'start' field of an exiting meeting with
  an hour less than the 'end' field has, but using '.' as hour separator
  instead ':' and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "Administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-02-01T20.00.00.000Z",
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
          "description" : "data.start should match format \"date-time\""
        }
      """

  @negative
  Scenario: Try to update the 'start' field of an exiting meeting with a
  date greater than the 'end' field has and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "Administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-05-01T20:00:00.000Z",
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
          "name" : "SchemaValidationError",
          "description" : "Start shouldn't be greater than End."
        }
      """

  @negative
  Scenario: Try to update the 'start' field of an exiting meeting with an
  hour greater than the 'end' field has and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "Administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "2019-03-01T21:00:00.000Z",
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
          "name" : "SchemaValidationError",
          "description" : "Start shouldn't be greater than End."
        }
      """

  @negative
  Scenario: Try to update the 'start' field of an exiting meeting with an
  hour greater than the 'end' field has and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "Administrator@arabitpro.local",
            "subject": "Subject Test",
            "body": "Body Test",
            "start": "",
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
          "description" : "data.start should match format \"date-time\""
        }
      """

  @positive
  Scenario: Try to update the 'start' field of an exiting meeting with a
  date less than the 'end' field has and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
          """
            {
              "organizer": "Administrator@arabitpro.local",
              "subject": "Subject Test",
              "body": "Body Test",
              "start": "2019-02-01T20:00:00.000Z",
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
      And the JSON at "start" should be "2019-02-01T20:00:00.000Z"