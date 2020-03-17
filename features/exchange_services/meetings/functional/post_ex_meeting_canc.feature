# Author: Daniel Cabero
@functional
Feature: FUNCTIONAL, post cancelation request with different option.

  Background: Creation exchanges meeting for before cancelation with the post request.
    Given I make a 'POST' request to '/meetings'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
        """
        {
          "subject": "Scrum",
          "body": "Scrum of Room Manager",
          "start": "2017-09-25T16:00:00.00Z",
          "end": "2017-09-25T17:00:00.00Z",
          "location": "Arani",
          "attendees": [
          "candace.flynn@server.lab"
          ],
          "optionalAttendees": [
          "stacy.hirano@server.lab"
          ]
        }
        """
    And I execute the request
    And I store the '_id' as '{meetingId}'

  Scenario:post cancelation request with location empty.
    When I make a 'POST' request to '/meetings/{meetingId}/cancellation'
    And I set this headers:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
        """
        {
          "subject": "Scrum",
          "body": "Scrum of Room Manager",
          "start": "2017-09-25T16:00:00.00Z",
          "end": "2017-09-25T17:00:00.00Z",
          "location": "",
          "attendees": [],
          "optionalAttendees": []
        }
        """

    And I execute the request
    Then I expect a '200' status code
    And the JSON response at "isCanceled" should be false


  Scenario: post cancelation request without body total
    When I make a 'POST' request to '/meetings/{meetingId}/cancellation'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
          """
          {
              "subject":"",
              "body":"",
              "start":"2017-09-25T17:00:00.00Z",
              "end": "2017-09-25T17:00:00.00Z",
              "location": "Arani",
              "attendees": [
              "candace.flynn@server.lab"
              ],
               "optionalAttendees": [
               "stacy.hirano@server.lab"
              ]
          }
          """

    And I execute the request
    Then I expect a '200' status code
    And the JSON response at "isCanceled" should be false


  Scenario: post cancelation request with meetingId invalid
    When I make a 'POST' request to '/meetings/meetingInvalid/cancellation'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
          """
            {
              "subject": "Scrum",
              "body": "Scrum of Room Manager",
              "start": "2017-09-25T16:00:00.00Z",
              "end": "2017-09-25T17:00:00.00Z",
              "location": "Arani",
              "attendees": [
              "candace.flynn@server.lab"
              ],
               "optionalAttendees": [
               "stacy.hirano@server.lab"
              ]
            }
          """

    And I execute the request
    Then I expect a '400' status code
    And a response body as:
        """
          {
            "description": "The meetingId 'invalidmeetingId' argument passed in must be a String of 12 bytes or a string of 24 hex characters.",
            "name": "InvalidIdFormatError"
          }
        """

  Scenario: post cancelation request with date incorrect(29/02)
    When I make a 'POST' request to '/meetings/{meetingId}/cancellation'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
          """
            {
              "subject": "Scrum",
              "body": "Scrum of Room Manager",
              "start": "2017-02-29T16:00:00.00Z",
              "end": "2017-02-29T17:00:00.00Z",
              "location": "Arani",
              "attendees": [
              "candace.flynn@server.lab"
              ],
               "optionalAttendees": [
               "stacy.hirano@server.lab"
              ]
            }
          """

    And I execute the request
    Then I expect a '400' status code
    And a response body as:
        """
           {
            "name": "SchemaValidationError",
            "description": "data.start should match format \"date-time\""
            }
        """


  Scenario: post cancelation request with date empty
    When I make a 'POST' request to '/meetings/{meetingId}/cancellation'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
          """
            {
              "subject": "Scrum",
              "body": "Scrum of Room Manager",
              "start": "",
              "end": "",
              "location": "Arani",
              "attendees": [
              "candace.flynn@server.lab"
              ],
               "optionalAttendees": [
               "stacy.hirano@server.lab"
              ]
            }
          """

    And I execute the request
    Then I expect a '400' status code
    And a response body as:
        """
           {
            "name": "SchemaValidationError",
            "description": "data.start should match format \"date-time\""
            }
        """


  Scenario: post cancelation request with body empty
    When I make a 'POST' request to '/meetings/{meetingId}/cancellation'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
          """
            {

            }
          """

    And I execute the request
    Then I expect a '400' status code
    And a response body as:
    """
        {
          "name": "SchemaValidationError",
          "description": "data should have required property 'attendees'"
        }
    """

  Scenario: post cancelation request with exchange credential invalid
    When I make a 'POST' request to '/meetings/{meetingId}/cancellation'
    And I set this headers exchange:
      | Exchange-Credentials | Env.invalid |
      | Exchange-Calendar    | Env.user_mail          |
    And I set this body:
          """
            {

            }
          """

    And I execute the request
    Then I expect a '401' status code
    And a response body as:
          """
            {
              "name": "UnauthorizedExchangeError",
              "description": "The provided credentials are incorrect."
             }
          """

