# Author: Daniel Cabero
@functional
Feature: FUNCTIONAL, put request for different cases.

  Background: Creation exchanges meeting for before update with the put request.
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

  @positive @meetings
  Scenario: put request without attenders.
    When I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
      """
        {
          "subject": "Scrum",
          "body": "Scrum of Room Manager",
          "start": "2017-10-25T16:00:00.00Z",
          "end": "2017-10-25T17:00:00.00Z",
          "location": "Arani",
          "attendees": [
          ],
          "optionalAttendees": [
          ]
        }
        """
    And I execute the request
    Then I expect a '200' status code
    And a response body excluide as:
        """
          {
          "subject": "Scrum",
          "body": "Scrum of Room Manager",
          "start": "2017-10-25T16:00:00.00Z",
          "end": "2017-10-25T17:00:00.00Z",
          "location": "Arani",
          "attendees": [
          ],
          "optionalAttendees": [
          ]
          }
        """

  @positive @meetings
  Scenario:put request with attenders empty .
    When I make a 'PUT' request to '/meetings/{meetingId}'
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
        "location": "",
        "attendees": [
               ],
        "optionalAttendees": [ "AT03@arabitpro.local"
        ]
      }
      """
    And I execute the request
    Then I expect a '200' status code
    And a response body excluide as:

    """
      {
        "subject": "Scrum",
        "body": "Scrum of Room Manager",
        "start": "2017-09-25T16:00:00.00Z",
        "end": "2017-09-25T17:00:00.00Z",
        "location": "",
        "attendees": [
               ],
        "optionalAttendees": [ "AT03@arabitpro.local"
        ]
      }
      """

  @negative @meetings
  Scenario:put request with account incorrect.
    When I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password         |
      | Exchange-Calendar    | Env.invalid_exchange |
    And I set this body:
          """
            {
              "subject": "Scrum",
              "body": "Scrum of Room Manager",
              "start": "2017-10-25T16:00:00.00Z",
              "end": "2017-10-25T17:00:00.00Z",
              "location": "Arani",
              "attendees": "",
              "optionalAttendees":""
            }
            """
    And I execute the request
    Then I expect a '400' status code
    And a response body as:
          """
            {
              "name": "SchemaValidationError",
              "description": "data.attendees should be array"
            }
          """

  @negative @meetings
  Scenario:put request with empty body.
    When I make a 'PUT' request to '/meetings/{meetingId}'
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

  @negative @meetings
  Scenario:put request with invalid date.
    When I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
          """
            {
              "subject": "Scrum",
              "body": "Scrum of Room Manager",
              "start": "2019-02-30T16:00:00.00Z",
              "end": "2019-02-30T17:00:00.00Z",
              "location": "Arani",
              "attendees": "",
              "optionalAttendees":""
            }
            """
    And I execute the request
    Then I expect a '400' status code
    And a response body as:
            """
              {
               "description": "data.attendees should be array",
                "name": "SchemaValidationError"
              }
            """

  @negative @meetings
  Scenario:put request with empty body and invalid credential.
    When I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.invalid_credential |
      | Exchange-Calendar    | Env.user_mail          |
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

  @negative @meetings
  Scenario: : Create a exchanges meeting with date incorrect(29/02)
    Given I make a 'PUT' request to '/meetings/{meetingId}'
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
              "name": "ExchangeError",
              "description": "The specified date isn't valid."
          }
        """

  @positive @meetings
  Scenario: update a exchanges meeting with invalid date without location
    Given I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
        """
        {
          "subject": "Scrum",
          "body": "Scrum of Room Manager",
          "start": "2018-09-25T16:00:00.00Z",
          "end": "2018-09-29T17:00:00.00Z",
          "location": "",
          "attendees": [
          "administrator@arabitpro.local"
          ],
          "optionalAttendees": [
          "stacy.hirano@server.lab"
          ]
        }
        """

    And I execute the request
    Then I expect a '200' status code
    And a response body excluide as:
         """
        {
          "subject": "Scrum",
          "body": "Scrum of Room Manager",
          "start": "2018-09-25T16:00:00.00Z",
          "end": "2018-09-29T17:00:00.00Z",
          "location": "",
          "attendees": [
          "administrator@arabitpro.local"
          ],
          "optionalAttendees": [
          "stacy.hirano@server.lab"
          ]
        }
        """

  @negative @meetings
  Scenario: update a exchanges meeting without start time and end time.
    Given I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
        """
        {
          "subject": "Scrum",
          "body": "Scrum of Room Manager",
          "start": "" ,
          "end": "",
          "location": "",
          "attendees": [
          "administrator@arabitpro.local"
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

  @negative @meetings
  Scenario: update a exchanges meeting with start, end time empty.
    Given I make a 'PUT' request to '/meetings/{meetingId}'
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
          "location": "",
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

  @negative @meetings
  Scenario: update a exchanges meeting with invalid meeting id
    Given I make a 'PUT' request to '/meetings/invalidmeetingId'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
        """
        {
          "subject": "Scrum",
          "body": "Scrum of Room Manager",
          "start": "2018-09-25T16:00:00.00Z",
          "end": "2018-09-29T17:00:00.00Z",
          "location": "arani",
          "attendees": [
          "administrator@arabitpro.local"
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

  @negative @meetings
  Scenario: update a exchanges meeting without subject and body
    Given I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
        """
        {

          "attendees": [
          "administrator@arabitpro.local"
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
            "description": "data should have required property 'subject'"
          }
        """

  @negative @meetings
  Scenario: update a exchanges meeting without body in the json.
    Given I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.password  |
      | Exchange-Calendar    | Env.user_mail |
    And I set this body:
        """
        {
          "subject": "Scrum",
          "start": "2018-09-25T16:00:00.00Z",
          "end": "2018-09-29T17:00:00.00Z",
          "location": "arani",
          "attendees": [
          "administrator@arabitpro.local"
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
            "description": "data should have required property 'body'"
          }
        """

  @negative @meetings
  Scenario: update a exchanges meeting without body, subject empty and invalid credential
    Given I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.invalid_credential |
      | Exchange-Calendar    | Env.user_mail          |
    And I set this body:
        """
        {
          "subject": "",
          "body": "",
          "start": "2017-09-25T16:00:00.00Z",
          "end": "2017-09-25T17:00:00.00Z",
          "location": "Arani",
          "attendees": [
          "administrator@arabitpro.local"
          ],
          "optionalAttendees": [
          "stacy.hirano@server.lab"
          ]
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

  @negative @meetings
  Scenario: example update a exchanges meeting without body, subject empty, invalid credential and invalid account
    Given I make a 'PUT' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | Env.invalid_credential |
      | Exchange-Calendar    | Env.invalid_exchange  |
    And I set this body:
         """
        {
          "subject": "",
          "body": "",
          "start": "2017-09-25T16:00:00.00Z",
          "end": "2017-09-25T17:00:00.00Z",
          "location": "Arani",
          "attendees": [
          "administrator@arabitpro.local"
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
        "name": "UnauthorizedExchangeError",
        "description": "The provided credentials are incorrect."
        }
      """