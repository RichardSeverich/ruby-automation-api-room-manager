#Author: Juan Aitken
@smoke @test
Feature: SMOKE, GET request to /meetings service

  Scenario: Make a GET request to /exchangeAccount service, it is expected to obtain an all the accouns in a json array.
    Given I make a 'GET' request to '/exchangeAccount'
       And I set this queries:
           | hostname | server2012dc.ArabITPro.local |
       And I load exchange server credentials
    When I execute the request
    Then I expect a '200' status code
        And a response body as:
				"""
					{
                    "userPrincipalName": "Administrator@ArabITPro.local",
                    "mail": "Administrator@arabitpro.local",
                    "displayName": "Administrator",
                    "name": "Administrator",
                    "sAMAccountName": "Administrator",
                    "mailNickname": "Administrator"}
				"""