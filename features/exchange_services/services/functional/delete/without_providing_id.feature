#Author: Juan Aitken
@functional @negative
Feature: DELETE Request to 'services' service without provide an ID

  Scenario: Delete request providing a valid 'serviceId'

    Given I make a 'DELETE' request to '/services/'
    Then I load exchange server credentials
      And I execute the request
    Then I expect a '400' status code
