#Author: Juan Aitken
@Functional
Feature: Funtional DELETE request to Services

  Background: Create a service
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
    And I store the '_id' as '{serviceId}'

  @delete_services
  Scenario: Delete request providing a valid 'serviceId'

    Given I make a 'DELETE' request to '/services/{serviceId}'
    Then I load exchange server credentials
      And I execute the request
    Then I expect a '204' status code

  @negative
  Scenario Outline: Delete request providing an invalid format and unregistered  'serviceId'

    When I make a 'DELETE' request to '/services/<serviceId>'
    And I execute the request
    Then I expect a '<status_code>' status code

    Examples:
      | serviceId                | status_code |
      | 5D93823a50f              | 400         |
      | 593823a50fb7f80f78bfb47e | 404         |


