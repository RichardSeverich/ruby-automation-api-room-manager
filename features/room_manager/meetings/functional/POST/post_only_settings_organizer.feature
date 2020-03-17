# Author: Daniel Montecinos

@rm @meetings @functional @post @negative
Feature: POST /meetings

  Scenario Outline: Try to create a meeting just setting organizer with
  different values
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer" : <organizer>
          }
        """
      And I execute the request
    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name" : "ValidationError",
            "description" : "data should have required property 'subject'"
          }
        """
    Examples:
      | organizer                       |
      | "RM@arabitpro.local"            |
      | "administrator@arabitpro.local" |
      | "administrator@arabitpro.local" |