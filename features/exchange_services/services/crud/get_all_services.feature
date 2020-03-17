#Author: Juan Aitken
@crud
Feature: SMOKE, GET request to services

  Scenario: Retrieve  the all the services
    Given I make a 'GET' request to '/services'
    When  I load exchange server credentials
    And I execute the request
    Then I expect a '200' status code
      And a response body as:
         """
             [{"_id": "598234b46f37260e040d3703",
             "name": "Exchange Server 2016",
             "version": "15.1 (Build 30225.42)",
              "serviceUrl": "https://server2012dc.arabitpro.local/EWS/Exchange.asmx"
            }]
         """
