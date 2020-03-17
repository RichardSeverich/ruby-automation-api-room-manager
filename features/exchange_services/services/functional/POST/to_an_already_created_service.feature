#Author: Juan Aitken
@functional
Feature: POST request to 'services' service using an already created service

  Background:
    Given I make a 'POST' request to '/services'
    When  I load exchange server credentials
      And I set this body:
            """
            {
            "hostname": "10.28.124.134",
            "username": "Administrator",
            "password": "ABC123}"
            }
            """
    When I execute the request

@delete_services
  Scenario: POST request to an already created service
    Given I make a 'POST' request to '/services'
    When I load exchange server credentials
      And I set this body:
           """
            {
            "hostname": "10.28.124.134",
            "username": "Administrator",
            "password": "ABC123}"
            }
            """
    When I execute the request
    Then I expect a '409' status code


