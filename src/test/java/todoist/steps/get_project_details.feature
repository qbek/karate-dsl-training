Feature: Get project details

  Scenario:
    Given path "/projects/", id
    When method get
    Then status 200