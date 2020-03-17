# Author: Pablo Ramirez
@rm @services @functional @negative
Feature: POST a new service with username field

  @delete_services
  Scenario Outline: Create a new service using username field
    Given I make a 'POST' request to '/services'
      And I set this body:
              """
              {
                "hostname": "server2012dc.arabitpro.local",
                "username": <username>,
                "password": "P@ssw0rd",
                "deleteLockTime": 11
              }
              """
    When I execute the request
    Then I expect a '400' status code
      And the JSON should be:
              """
              {
                "name":"<response_name>",
                "description":"<response_description>"
              }
              """
    Examples:
      | username                                                                                                                                                                                                                                                                                                                           | response_name           | response_description                                  |
      | ""                                                                                                                                                                                                                                                                                                                                 | ValidationError         | data.username should NOT be shorter than 1 characters |
      | "Incorrect"                                                                                                                                                                                                                                                                                                                        | InvalidCredentialsError | The credentials entered are not correct               |
      | "Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_" | InvalidCredentialsError | The credentials entered are not correct               |
      | 2017                                                                                                                                                                                                                                                                                                                               | ValidationError         | data.username should be string                        |
