Feature: Get all projects

  Scenario:
    Given path "/projects"
    When method get
    Then status 200