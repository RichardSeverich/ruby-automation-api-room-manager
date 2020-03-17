# Author: Daniel Montecinos

@rm @meetings @functional @post @negative
Feature: POST /meetings

  Scenario Outline: Try to create a meeting only setting: organizer with a valid
  'room' email, subject  and body with a  string greater than 0 and less
  than or equal to 255 and start a correct date and end with different dates

    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer" : "RM@arabitpro.local",
            "subject" : "Subject Test",
            "body" : "Body Test",
            "start" : "2019-03-02T01:00:00.000Z",
            "end" : <end>
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
      | end                      |
      | "2019-04-02T02:00:00.000Z" |
      | "2019-03-02T01:00:00.000Z" |
      | "2019-03-02T00:00:00.000Z" |
      | "2019-13-02T01:00:00.000Z" |
      | "2019-03-02T01:00:00.000Z" |

  Scenario Outline: Try to create a meeting only setting: organizer with a valid
  'room' email, subject  and body with a  string greater than 0 and less
  than or equal to 255 and start with a correct date and end with different values
  date
    When I make a 'POST' request to '/meetings'
      And I set this body:
        """
          {
            "organizer" : "RM@arabitpro.local",
            "subject" : "Subject Test",
            "body" : "Body Test",
            "start" : "2019-03-02T01:00:00.000Z",
            "end" : <end>
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
      | end                            |
      | "any kind of string"             |
      | "2019-03-31TZ"                   |
      | "2019-03-31T25:75:94.000Z"       |
      | "2019-03-31Tany_kind_of_stringZ" |
      | "2019-03-31Tany_kind_of_stringZ" |