# Author: Daniel Montecinos

@rm @meetings @functional @post
Feature: POST /meetings

  @negative @issue
  Scenario Outline: Try to create a meeting, setting a string greater than 255
  characters as value for 'subject' parameter in the request body
    When I make a 'POST' request to '/meetings'
      And I set this body:
          """
            {
              "organizer": "<organizer>",
              "subject": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vulputate ornare purus, ut viverra ex semper sed. Proin egestas turpis quis nulla laoreet bibendum. Suspendisse fermentum porttitor nisl, vitae vulputate sapien pharetra quis. Praesent metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vulputate ornare purus, ut viverra ex semper sed. Proin egestas turpis quis nulla laoreet bibendum. Suspendisse fermentum porttitor nisl, vitae vulputate sapien pharetra quis. Praesent metus. ",
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
    Examples:
      |organizer  |
      |administrator@arabitpro.local  |
      |RM@arabitpro.local  |

  @positive
  Scenario: Try to create a meeting, setting an empty string as
  value for 'subject' parameter in the request body
    When I make a 'POST' request to '/meetings'
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
