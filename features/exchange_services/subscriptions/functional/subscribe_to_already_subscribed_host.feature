#Author: Juan Aitken
@functional @negative
Feature: FUNCTIONAL, Functional tests for Subscriptions service of Exchange Server API

  Background:

  Given I make a 'POST' request to '/subscriptions'
  When I load exchange server credentials
    And  I set this body:
       """
         {
           "host": "localhost",
           "port": 7070,
           "notificationUrl": "/api/v1/notifications"
         }
       """
     And I execute the request

  Scenario: POST request to subscribe an already subscribed host

    Given I make a 'POST' request to '/subscriptions'
    When I load exchange server credentials
      And  I set this body:
         """
          {
           "host": "localhost",
           "port": 7070,
           "notificationUrl": "/api/v1/notifications"
          }
         """
      And I execute the request
    Then I expect a '409' status code
     And a response body as:
         """
        {
           "name": "ConflictValue",
           "description": "Conflict with a host with same name, the host needs to be unique."
        }
         """

































