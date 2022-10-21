Feature: get_all_projects

  Scenario:
    Given path "/projects"
    When method get
    Then status 200