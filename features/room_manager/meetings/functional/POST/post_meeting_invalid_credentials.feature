# Author: Daniel Montecinos

@rm @meetings @functional @post @negative
Feature: POST /meetings

  Scenario Outline: Try to create a meeting using invalid
  credentials
    When I make a 'POST' request to '/meetings'
      And I change the "value" of "Credentials" to "<credentials>"
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
    Then I expect a '401' status code
      And the JSON should be:
        """
          {
            "name" : "UnauthorizedExchangeError",
            "description" : "The provided credentials are incorrect."
          }
        """
    Examples:
      | credentials       |
      | ""                |
      | P@ssW0rd          |
      | !@#$$%^^&***())_+ |