# Author: Daniel Montecinos

@rm @meetings @functional @put
Feature: PUT /meetings/{meetingId}

  Background: Create a meeting and set 'subject' field with string greater
  than 0 and less than or equal to 20 (set the remaining parameters with
  correct values) and store its id
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
  Scenario: Try to update the 'subject' field of an exiting meeting with
  a string of 255 characters and using a valid id
    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "RMONE@arabitpro.local",
            "subject": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vulputate ornare purus, ut viverra ex semper sed. Proin egestas turpis quis nulla laoreet bibendum. Suspendisse fermentum porttitor nisl, vitae vulputate sapien pharetra quis. Praesent metus.",
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
    Then I expect a '200' status code
      And the JSON at "subject" should be "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vulputate ornare purus, ut viverra ex semper sed. Proin egestas turpis quis nulla laoreet bibendum. Suspendisse fermentum porttitor nisl, vitae vulputate sapien pharetra quis. Praesent metus."

  @positive
  Scenario: Try to update the 'subject' field of an exiting meeting with an
  empty string

    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "Administrator@arabitpro.local",
            "subject": "",
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
    Then I expect a '200' status code
      And the JSON at "subject" should be ""

  @negative
  Scenario: Try to update the 'subject' field of an exiting meeting with a
  string greater than 255 characters and using a valid id

    When I make a 'PUT' request to '/meetings/{meetingId}'
      And I set this body:
        """
          {
            "organizer": "Administrator@arabitpro.local",
            "subject": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vulputate ornare purus, ut viverra ex semper sed. Proin egestas turpis quis nulla laoreet bibendum. Suspendisse fermentum porttitor nisl, vitae vulputate sapien pharetra quis. Praesent metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vulputate ornare purus, ut viverra ex semper sed. Proin egestas turpis quis nulla laoreet bibendum. Suspendisse fermentum porttitor nisl, vitae vulputate sapien pharetra quis. Praesent metus.",
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
            "name" : "MeetingNotUpdated",
            "description" : "The meeting could not be Updated"
          }
        """
