# Author: Pablo Ramirez
@rm @services @functional @negative
Feature: POST a new service with password field

  @delete_services
  Scenario Outline: Create a new service using password field
    Given I make a 'POST' request to '/services'
      And I set this body:
              """
              {
                "hostname": "server2012dc.arabitpro.local",
                "username": "Administrator",
                "password": <password>,
                "deleteLockTime": 10
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
      | password                                                                                                                                                                                                                                                                                                                           | response_name           | response_description                                  |
      | ""                                                                                                                                                                                                                                                                                                                                 | ValidationError         | data.password should NOT be shorter than 1 characters |
      | "Incorrect"                                                                                                                                                                                                                                                                                                                        | InvalidCredentialsError | The credentials entered are not correct               |
      | "Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_Incorrect_value_" | InvalidCredentialsError | The credentials entered are not correct               |
      | 2017                                                                                                                                                                                                                                                                                                                               | ValidationError         | data.password should be string                        |
