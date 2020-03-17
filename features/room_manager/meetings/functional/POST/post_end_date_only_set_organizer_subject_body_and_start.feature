# Author: Daniel Montecinos

@rm @meetings @functional @post @negative
Feature: POST /meetings

  Scenario Outline: Try to create a meeting only setting: organizer with a valid
  'room' email, subject  and body with a  string greater than 0 and less
  than or equal to 255 and start with different dates and end with a correct
  date
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer" : "RM@arabitpro.local",
            "subject" : "Subject Test",
            "body" : "Body Test",
            "start" : <start>,
            "end" : "2019-03-31T22:59:59.000Z"
          }
          """
      And I execute the request
    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name" : "ValidationError",
            "description" : "data should have required property 'rooms'"
          }
        """
    Examples:
      | start                            |
      | "2019-04-02T23:59:59.000Z"       |
      | "2019-03-31T23:59:59.000Z"       |
      | "2019-03-31T23:59:59.000Z"       |
      | "2019-02-31T23:59:59.000Z"       |
      | "2019-03-31T22:59:59.000Z"       |

  Scenario Outline: Try to create a meeting only setting: organizer with a valid
  'room' email, subject  and body with a  string greater than 0 and less
  than or equal to 255 and start with different values and end with a correct
  date
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer" : "RM@arabitpro.local",
            "subject" : "Subject Test",
            "body" : "Body Test",
            "start" : <start>,
            "end" : "2019-03-31T22:59:59.000Z"
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
      | start                            |
      | "any kind of string"             |
      | "2019-03-31TZ"                   |
      | "2019-03-31T25:75:94.000Z"       |
      | "2019-03-31Tany_kind_of_stringZ" |
      | "2019-03-31Tany_kind_of_stringZ" |