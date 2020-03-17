#Author: Juan Aitken
@functional @negative
Feature: Functional test using PUT request on 'services' service

  Background: Create a service
    Given I make a 'POST' request to '/services/'
    And I set this body:
         """
          {
            "hostname": "server2012dc.arabitpro.local",
            "username": "Administrator",
            "password": "P@ssw0rd"
          }
         """
    When I execute the request
    And I store the '_id' as '{serviceId}'

  Scenario Outline: PUT request providing a invalid format  and an unregistered 'serviceId'

    When I make a 'PUT' request to '/services/{<service_id>}'
    And I set this body:
      """
       {
          "username": "Juan Aitken",
          "password": "P@ssw0rd"
        }
      """
    When I execute the request
    Then I expect a '<status_code>' status code

    Examples:
      | service_id               | status_code |
      | aas0c04c6f37260e040dAAAA | 400         |
      | 598f2d8c6f37260e040d38c4 | 404         |

