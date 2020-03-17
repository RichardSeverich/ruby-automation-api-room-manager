# Author: Pablo Ramirez
@rm @services @functional @positive
Feature: PUT an existing service

  Background: Create a service
    Given I make a 'POST' request to '/services'
      And I set this body:
          """
          {
            "hostname": "Env.hostname",
            "username": "Env.user",
            "password": "Env.password",
            "deleteLockTime": 11
          }
          """
      And I replace the values of the body request
    When I execute the request
      And I store the '_id' as '{serviceId}'

  @delete_services
  Scenario: Update a service created using a different deleteLockTime
  when the service is created

    Given I make a 'PUT' request to '/services/{serviceId}'
      And I set this body:
          """
          {
            "username": "Env.user",
            "password": "Env.password",
            "deleteLockTime": 11
          }
          """
      And I replace the values of the body request
    When I execute the request
    Then I expect a '200' status code
      And the JSON should have the following:
        | type           | "ExchangeServer"        |
        | name           | "Exchange Server 2016"  |
        | version        | "15.1 (Build 30225.42)" |
        | deleteLockTime | 11                      |
