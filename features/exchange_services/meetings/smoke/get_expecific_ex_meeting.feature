# Author: Daniel Cabero
Feature: SMOKE, GET request to a specific exchanges meeting

  Background: Create a meeting
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

  @smoke @meetings @positive
  Scenario: Retrieve a specific  exchange meeting
    When I make a 'GET' request to '/meetings/{meetingId}'
    And I set this headers exchange:
      | Exchange-Credentials | 'Env.password'   |
      | Exchange-Calendar    | 'Env.user_mail'  |
    And I execute the request
    Then I expect a '200' status code
    And a response body excluide as:
     """
      {
        "subject": "Scrum",
        "body": "Scrum of Room Manager",
        "start": "2017-09-25T16:00:00.00Z",
        "end": "2017-0-25T17:00:00.00Z",
        "location": "Arani",
        "attendees": [
        "candace.flynn@server.lab"
        ],
        "optionalAttendees": [
        "stacy.hirano@server.lab"
        ]
      }
      """