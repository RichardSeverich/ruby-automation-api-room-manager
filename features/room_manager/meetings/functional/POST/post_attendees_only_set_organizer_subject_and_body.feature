# Author: Daniel Montecinos

@rm @meetings @functional @post @negative
Feature: POST /meetings

  Scenario Outline: Try to create a meeting only setting: organizer with a
  valid 'user' email, subject with a string greater than 0 and less than
  or equal to 255 and body with different values
    When I make a 'POST' request to '/meetings'
      And I set this body:
          """
            {
              "organizer" : "RM@arabitpro.local",
              "subject" : "Subject Test",
              "body" : <body>
            }
          """
      And I execute the request
    Then I expect a '400' status code
      And the JSON should be:
        """
          {
            "name" : "ValidationError",
            "description" : "data should have required property 'start'"
          }
        """
    Examples:
      | body                                                                                                                                                                                                                                                           |
      | ""                                                                                                                                                                                                                                                                |
      | "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vulputate ornare purus, ut viverra ex semper sed. Proin egestas turpis quis nulla laoreet bibendum. Suspendisse fermentum porttitor nisl, vitae vulputate sapien pharetra quis. Praesent metus." |